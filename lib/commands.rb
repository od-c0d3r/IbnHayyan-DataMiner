require 'nokogiri'
require 'open-uri'

class Commands
  def create_nokogiri(source)
    Nokogiri::HTML(URI.open(source))
  end
end
