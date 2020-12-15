require_relative '../lib/commands'
require_relative '../lib/search'

describe Search do
  let(:search) { Search.new('harry potter') }
  let(:cmd) { Commands.new }
  let(:html) { 'https://www.pdfdrive.com/search?q=test&pagecount=&pubyear=&searchin=&em=' }
  let(:new_xml) { cmd.create_nokogiri('https://www.yahoo.com') }

  describe '#initialize' do
    it 'Creates a new Commands class instance' do
      expect(search).to be_instance_of Search
    end
  end

  describe '#create_xml' do
    it 'Return XML file string from passed HTML document' do
      expect(new_xml).to be_a Nokogiri::HTML::Document
    end
  end

  describe '#results_counter' do
    it 'Return string representing results counter from pdfdrive.com' do
      new_xml = cmd.create_nokogiri(html)
      expect(search.results_counter(new_xml)).to be_a String
    end
  end

  describe '#analyze_resultes' do
    it 'Return array of data representing search results' do
      new_xml = cmd.create_nokogiri(html)
      expect(search.analyze_resultes(new_xml)).to be_a Array
    end
  end

  describe '#windows?' do
    RUBY_PLATFORM = 'x64-mingw32'

    it 'Return true if user OS is windows' do
      expect(search.windows?).to be true
    end

    it "Return false if user OS isn\'t windows" do
      expect(search.windows?).not_to be false
    end
  end
end
