require 'nokogiri'
require 'open-uri'

# welcome screen
puts "
          ______________________________
        /  \\                            \\.
        |   |                            |.
        \\__ |                            |.
            |                            |.
    ▀█▀ █▀▀▄ █▀▀▄ 　 ▒█░▒█ █▀▀█ █░░█ █░░█ █▀▀█ █▀▀▄ 　
    ▒█░ █▀▀▄ █░░█ 　 ▒█▀▀█ █▄▄█ █▄▄█ █▄▄█ █▄▄█ █░░█ 　
    ▄█▄ ▀▀▀░ ▀░░▀ 　 ▒█░▒█ ▀░░▀ ▄▄▄█ ▄▄▄█ ▀░░▀ ▀░░▀ 　

    ▒█▀▀▄ █▀▀█ ▀▀█▀▀ █▀▀█ 　 █▀▄▀█ ░▀░ █▀▀▄ █▀▀ █▀▀█
    ▒█░▒█ █▄▄█ ░░█░░ █▄▄█ 　 █░▀░█ ▀█▀ █░░█ █▀▀ █▄▄▀
    ▒█▄▄▀ ▀░░▀ ░░▀░░ ▀░░▀ 　 ▀░░░▀ ▀▀▀ ▀░░▀ ▀▀▀ ▀░▀▀
            |                            |.
            |   _________________________|___
            |  /                            /.
            \\_/____________________________/.
"

# Terms of use "you must have the legal right to download the content you are accessing through our servers"
puts "\n                Terms of use  "
print " You must have the legal right to download\nthe content you are accessing through my App. ↲ "
gets.chomp
puts ''

# asking user for search input and maximum row per page
print 'Enter Your Search : '
usr_input = gets.chomp.strip

# Fetch and parse HTML document
src = "https://www.pdfdrive.com/search?q=#{usr_input}&pagecount=&pubyear=&searchin=&em="
home_src = Nokogiri::HTML(URI.open(src))

# searching and displaying the results
puts home_src.css('div #result-found')[0].content.strip # Search result conter
link_num = [nil]

home_src.css('div.file-right').each_with_index do |link, index|
  puts ''
  puts "object - #{link}"
  puts ''
  puts "object index - #{index + 1}"
  puts "object title - #{link.at_css('h2').content}"
  puts "object info - #{link.at_css('div.file-info').content.strip}"
  puts "object link - #{src.match(%r{\A(https?://)?([\w\d]+)\.([\w\d.]+)}).to_s + link.at_css('a')['href']}"
  link_num << (src.match(%r{\A(https?://)?([\w\d]+)\.([\w\d.]+)}).to_s + link.at_css('a')['href']).to_s
  puts ''
end

print 'Type Link index then press Enter : '
user_input = gets.chomp.strip
system("start #{link_num[user_input.to_i]}")
