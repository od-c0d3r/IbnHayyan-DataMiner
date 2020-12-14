require 'nokogiri'
require 'open-uri'
require '../lib/commands'

describe Commands do
  let(:cmd) { Commands.new }

  describe '#create_nokogiri(source)' do
    it 'Return Xml file string' do
      new_xml = cmd.create_nokogiri('https://www.yahoo.com')
      expect(new_xml).to be_a Nokogiri::HTML::Document
    end
  end
end
