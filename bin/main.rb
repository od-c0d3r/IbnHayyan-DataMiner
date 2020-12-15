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
puts "\n                           Made by \n                    github.com/od-c0d3r  "
print "      A web data mining tool for pdf files extension \n       crafted with Nokogiri (鋸) RubyGem and Ruby."
puts ''

# Terms of use
puts "\n                        Terms of use  "
print "     You must have the legal right to download the \n       content you are accessing through my App. ↲ "
gets.chomp
puts ''

# Asking user for search input
user_input = 'search'
while user_input == 'search'
  print 'Search for : '
  usr_input = gets.chomp.strip
  until usr_input.match(/[0-9a-zA-Z]/)
    print 'Invalid:> Search for : '
    usr_input = gets.chomp.strip
  end

  # Fetch and parse HTML document
  search = Search.new(usr_input.to_s)
  search_xml = search.create_xml
  puts search.analyze_resultes(search_xml)

  puts "Enter file index to open in your defualt browser \nOr tpye 'search' for new query : "
  user_input = gets.chomp.strip

  until (user_input.to_i.positive? && user_input.to_i < 21) || user_input == 'search'
    puts "Invalid:> Enter file index to open in your defualt browser \nOr tpye 'search' for new query : "
    user_input = gets.chomp.strip
  end

  while user_input.to_i.positive? && user_input.to_i < 21
    if search.windows?
      system("start #{search.results_links[user_input.to_i]}")
    else
      system("sensible-browser #{search.results_links[user_input.to_i]}")
    end
    puts "Enter file index to open in your defualt browser \nOr tpye 'search' for new query : "
    user_input = gets.chomp.strip

    until (user_input.to_i.positive? && user_input.to_i < 21) || user_input == 'search'
      puts "Invalid:> Enter file index to open in your defualt browser \nOr tpye 'search' for new query : "
      user_input = gets.chomp.strip
    end
  end
end
