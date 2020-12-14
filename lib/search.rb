require_relative './commands'

class Search
  @@links = [nil]
  attr_reader :results_links

  def initialize(query)
    @query = query
    @repository = ["https://www.pdfdrive.com/search?q=#{@query}&pagecount=&pubyear=&searchin=&em="]
    @cmd = Commands.new
    @results_links = [nil]
  end

  def create_xml
    @cmd.create_nokogiri(@repository[0])
    # home_src = Nokogiri::HTML(URI.open(@reposorty[0]))
  end

  def results_counter(xml_page)
    xml_page.css('div #result-found')[0].content.strip
  end

  def analyze_resultes(xml_page)
    xml_page.css('div.file-right').each_with_index do |data, index|
      puts ''
      puts "object index - #{index + 1}"
      puts "object title - #{data.at_css('h2').content}"
      puts "object info - #{data.at_css('div.file-info').content.strip}"
      pdf_link = @repository[0].match(%r{\A(https?://)?([\w\d]+)\.([\w\d.]+)}).to_s + data.at_css('a')['href']
      puts "object link - #{pdf_link}"
      @results_links << pdf_link.to_s
      puts ''
    end
    @@links << @results_links
  end
end

new_search = Search.new('hello')

search_xml = new_search.create_xml
puts new_search.results_counter(search_xml)
new_search.analyze_resultes(search_xml)

print 'Type Link index then press Enter : '
user_input = gets.chomp.strip
system("start #{new_search.results_links[user_input.to_i]}")
