s = Gem::Specification.new do |s|
  s.name        = 'arxiv-h'
  s.version     = '0.0.2'
  s.summary     = 'Simple wrapper for the Arxiv API'
  s.description = 'Simple wrapper for Arxiv API exposing common fields.'
  s.authors     = ['Peter Lubell-Doughtie']
  s.email       = 'peter@helioid.com'
  s.files       = ['lib/arxiv.rb']
  s.homepage    = 'http://www.helioid.com/'
end

s.add_dependency('nokogiri')
s
