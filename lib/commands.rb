require 'nokogiri'
require 'open-uri'

class Commands
  def initialize; end

  def create_nokogiri(source)
    Nokogiri::HTML(URI.open(source))
  end
end
