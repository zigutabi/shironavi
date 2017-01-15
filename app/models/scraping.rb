

class Scraping
  def self.shiro_urls
    links = []
    agent = Mechanize.new
    current_page = agent.get('https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E5%9F%8E%E4%B8%80%E8%A6%A7')
    elements = current_page.search('ul li a')
    elements.each do |ele|
      break if ele.get_attribute('title') == "グスク"
      next if ele.get_attribute('title') == "Wikipedia:曖昧さ回避"
      next if ele.get_attribute('class') == "new"
      links << ele.get_attribute('href')
    end

    #links.each do |link|
    #  compile_dt_shiro('https://ja.wikipedia.org' + link)
    #end
  end

  def self.compile_dt_shiro(link)
    
    agent = Mechanize.new
    page = agent.get(link)
    #return unless page.search('#firstHeading').inner_text include?("作成中")

    puts page.search('#firstHeading').inner_text

    #elements.page.search('span').each do |ele|
    #  puts ele.get_attribute('title').inner_text if ele.get_attribute('title') == "この位置の地図やなどをリンクするページを表示します"
    #end

    #if page.search('a.external span').get_attribute('title') == "この位置の地図やなどをリンクするページを表示します"
    #  puts page.search('a.external span').inner_text
    #elsif page.search('span.latitude')
    #  puts page.search('span.latitude').inner_text
    #  puts page.search('span.longitude').inner_text
    #end
  end
end