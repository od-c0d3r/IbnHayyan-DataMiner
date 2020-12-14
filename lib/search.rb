require_relative './commands'

class Search
  attr_reader :results_links

  def initialize(query)
    @query = query
    @repository = ["https://www.pdfdrive.com/search?q=\"#{@query}\"&pagecount=&pubyear=&searchin=&em=1"]
    @cmd = Commands.new
    @results_links = [nil]
  end

  def create_xml
    @cmd.create_nokogiri(@repository[0])
  end

  def results_counter(xml_page)
    xml_page.css('div #result-found')[0].content.strip
  end

  def analyze_resultes(xml_page)
    xml_page.css('div.file-right').each_with_index do |data, index|
      puts ''
      puts "File index - #{index + 1}"
      puts "File title - #{data.at_css('h2').content}"
      puts "File info - #{data.at_css('div.file-info').content.strip}"
      pdf_link = @repository[0].match(%r{\A(https?://)?([\w\d]+)\.([\w\d.]+)}).to_s + data.at_css('a')['href']
      @results_links << pdf_link.to_s
      puts ''
    end
  end

  def search_check(usr_input)
    usr_input.match(/0-9a-zA-Z/)
  end

  def windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end
end
