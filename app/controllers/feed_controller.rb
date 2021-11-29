class FeedController < ApplicationController
  require 'rss'
  require 'open-uri'
  def news
    rss_results = []
    rss = RSS::Parser.parse(open('http://feeds.feedburner.com/mjbizdaily/XdPJ').read, false).items[0..5]
    
 rss.each do |result|
      result = { title: result.title, date: result.pubDate, link: result.link, description: result.description }
      rss_results.push(result)
    end
      @news = rss_results


  end


  

end
