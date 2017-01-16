

class Scraping
  def self.shiro_urls
    count = 0
    links = []
    agent = Mechanize.new
    current_page = agent.get('https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E5%9F%8E%E4%B8%80%E8%A6%A7')
    elements = current_page.search('ul li a')
    elements.each do |ele|
      break if count == 10
      break if ele.get_attribute('title') == "グスク"
      next if ele.get_attribute('title') == "Wikipedia:曖昧さ回避"
      next if ele.get_attribute('title') == "アイヌ民族"
      next if ele.get_attribute('class') == "new"
      links << ele.get_attribute('href')
      count = count + 1
    end

    links.each do |link|
      compile_dt_shiro('https://ja.wikipedia.org' + link)
    end
  end

  def self.compile_dt_shiro(link)
    shiro_name = nil
    shiro_lat = nil
    shiro_lng = nil

    agent = Mechanize.new
    page = agent.get(link)

    shiro_name = page.at('#firstHeading').inner_text if page.at('#firstHeading')
    if page.at('.external span')
      ltn = page.at('.external span').inner_text.gsub(/(\r\n|\r|\n|\f)/,"").sub("秒", "秒,")
      arr_ltn = ltn.split(",")
      shiro_lat = arr_ltn[0]
      shiro_lng = arr_ltn[1]
      unless shiro_lat == 0 || shiro_lat.blank? || shiro_lng == 0 || shiro_lng.blank?
        shiro = Shiro.new
        shiro.name = shiro_name
        shiro.latitude = shiro_lat
        shiro.longitude = shiro_lng
        shiro.save
      end
    end
  end
end