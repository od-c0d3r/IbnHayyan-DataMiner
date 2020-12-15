require 'nokogiri'
require 'open-uri'
require_relative '../lib/commands'

describe Commands do
  let(:cmd) { Commands.new }

  describe '#initialize' do
    it 'Creates a new Commands class instance' do
      expect(cmd).to be_instance_of Commands
    end
  end

  describe '#create_nokogiri(source)' do
    it 'Return Xml file string' do
      new_xml = cmd.create_nokogiri('https://www.yahoo.com')
      expect(new_xml).to be_a Nokogiri::HTML::Document
    end
  end
end
