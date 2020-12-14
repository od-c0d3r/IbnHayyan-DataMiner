require './lib/search'

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
puts "\n                           Made by \n                    githun.com/od-c0d3r  "
print "      A web data mining tool for pdf files extension \n       crafted with Nokogiri (鋸) RubyGem and Ruby."
puts ''
# Terms of use "you must have the legal right to download the content you are accessing through our servers"
puts "\n                        Terms of use  "
print "     You must have the legal right to download the \n       content you are accessing through my App. ↲ "
gets.chomp
puts ''

# asking user for search input and maximum row per page
print 'Search for : '
usr_input = gets.chomp.strip
until usr_input.match(/[0-9a-zA-Z]/)
  print 'Invalid:> Search for : '
  usr_input = gets.chomp.strip
end

# Fetch and parse HTML document
new_search = Search.new(usr_input.to_s)
search_xml = new_search.create_xml
puts new_search.results_counter(search_xml)
new_search.analyze_resultes(search_xml)

print 'Enter index to open in the default browser : '
user_input = gets.chomp.strip
while user_input.to_i > 20 || user_input.to_i < 1
  print 'Invalid:> Enter index to open in the default browser : '
  user_input = gets.chomp.strip
end

if new_search.windows?
  system("start #{new_search.results_links[user_input.to_i]}")
else
  system("sensible-browser #{new_search.results_links[user_input.to_i]}")
end
