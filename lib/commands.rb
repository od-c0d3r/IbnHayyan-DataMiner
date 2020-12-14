require 'nokogiri'
require 'open-uri'

class Commands
  def initialize; end

  def create_nokogiri(source)
    Nokogiri::HTML(URI.open(source))
  end

  def results_counter()
    home_src.css('div #result-found')[0].content.strip
  end
end
