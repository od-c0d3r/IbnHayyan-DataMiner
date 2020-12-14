require_relative './commands'

class Search
  def initialize(query)
    @query = query
    @reposorty = ["https://www.pdfdrive.com/search?q=#{@query}&pagecount=&pubyear=&searchin=&em="]
    @cmd = Commands.new
  end

  def start
    @cmd.create_nokogiri(@reposorty[0])
    # home_src = Nokogiri::HTML(URI.open(@reposorty[0]))
  end
end

search = Search.new('hello')

search.start
