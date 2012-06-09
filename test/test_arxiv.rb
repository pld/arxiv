require 'test/unit'
require 'arxiv'

class ArxivTest < Test::Unit::TestCase
  def test_set_referer
    rg = Arxiv.new('ref')
    assert_equal 'ref', rg.referer
  end

  def test_set_num_results
    rg = Arxiv.new('', 100)
    assert_equal 100, rg.num_results
  end

  def test_set_start_results
    rg = Arxiv.new('', 1, 100)
    assert_equal 100, rg.start_results
  end

  # requires internet connectivity
  def test_get_search_response
    rg = Arxiv.new
    assert_equal false, rg.search('nano fibers').empty?
  end

  # requires internet connectivity
  def test_get_num_search_response
    rg = Arxiv.new('example.com', 10)
    assert_equal 10, rg.search('nano fibers').length
  end

  # requires internet connectivity
  def test_search_field
    # use a valid springer key to run test
    rg = Arxiv.new
    assert_equal false, rg.search('nano', 'ti').empty?
  end
end

