require 'rubygems'

require 'json'
require 'net/http'
require 'nokogiri'
require 'uri'


Result = Struct.new :title, :abstract, :url, :date, :authors


class Arxiv

  # Base api query url
  API_PATH = 'http://export.arxiv.org/api/query?' 
  API_URI = URI.parse(API_PATH)

  attr_accessor :referer, :start_results, :num_results

  def initialize(referer='', num_results=50, start_results=0)
    @referer = referer
    @start_results = start_results
    @num_results = num_results
  end

  def search(query, field='all')
    api = API_URI
    api_call = Net::HTTP.new(api.host)
    
    params = "?search_query=#{field}:#{query}&start=#{@start_results}"
    params += "&max_results=#{@num_results}"

    response = api_call.get2(api.path + params, { 'Referer' => @referer })
    return nil if response.class.superclass == Net::HTTPServerError

    doc = Nokogiri::HTML(response.body)
    doc.xpath('//feed/entry').map do |item|
      authors = item.xpath('author').map { |author| author.xpath('name').text }
      Result.new(
        item.xpath('title').text,
        item.xpath('summary').text.gsub("\n", ' ').strip,
        item.xpath('id').text,
        item.xpath('published').text,
        authors
      )
    end
  end
end
