class Scraping
  def self.shiro_urls
    links = []
    agent = Mechanize.new
    current_page = agent.get('https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E5%9F%8E%E4%B8%80%E8%A6%A7')
    elements = current_page.search('ul li a')
    elements.each do |ele|
      if ele.get_attribute('title') = "グスク"
        break
      end
      links << ele.get_attribute('href')
    end

    links.each do |link|
      compile_dt_shiro('https://ja.wikipedia.org' + link)
    end
  end

  def self.compile_dt_shiro(link)
    agent = Mechanize.new
    page = agent.get(link)
    puts page.search('#firstHeading').inner_text
  end
end