class Scraping
  # 取得した緯度情報
  LAT = "北緯"
  LNG = "東経"
  ANG1 = "度"
  ANG2 = "分"
  ANG3 = "秒"

  # クローラー先
  PASS_FULL = 'https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E5%9F%8E%E4%B8%80%E8%A6%A7'
  PASS = 'https://ja.wikipedia.org'

  # 不要なリンク先
  ST_WD = "グスク"
  ES_TL1 = "Wikipedia:曖昧さ回避"
  ES_TL2 = "アイヌ民族"
  ES_CL = "new"

  def self.shiro_urls
    count = 0
    links = []
    agent = Mechanize.new
    current_page = agent.get(PASS_FULL)
    elements = current_page.search('ul li a')
    elements.each do |ele|
      break if count == 10
      break if ele.get_attribute('title') == ST_WD
      next if ele.get_attribute('title') == ES_TL1
      next if ele.get_attribute('title') == ES_TL2
      next if ele.get_attribute('class') == ES_CL
      links << ele.get_attribute('href')
      count = count + 1
    end

    links.each do |link|
      compile_dt_shiro(PASS + link)
    end
  end

  def self.compile_dt_shiro(link)
    shiro_name = nil
    l_pos_x = nil
    l_pos_y = nil

    agent = Mechanize.new
    page = agent.get(link)

    shiro_name = page.at('#firstHeading').inner_text if page.at('#firstHeading')
    return unless page.at('.external span')
    
    ltn = page.at('.external span').inner_text.gsub(/(\r\n|\r|\n|\f)/,"").sub(ANG3, ANG3 + ",")
    arr_ltn = ltn.split(",")
    l_pos_x = format_pos(arr_ltn[0])
    l_pos_y = format_pos(arr_ltn[1])
    w_pos_x = change_pos_x(l_pos_x, l_pos_y)
    w_pos_y = change_pos_y(l_pos_x, l_pos_y)
    #puts w_pos_x
    #puts w_pos_y
    unless w_pos_x == 0 || w_pos_x.blank? || w_pos_y == 0 || w_pos_y.blank?
      shiro = Shiro.new
      shiro.name = shiro_name
      shiro.latitude = w_pos_x
      shiro.longitude = w_pos_y
      shiro.save
    end
  end

  # 漢字交じりの値を数値のみに変換
  def self.format_pos(pos)
    aft_pos = ""
    words = []
    # 小数点以下の値を整える
    pos = pos.sub("\s", "").sub(LAT, "").sub(LNG, "").sub(ANG1, ",").sub(ANG2, ",").sub(".", ",").sub(ANG3, "")
    words = pos.split(",")
    fs_wd = words.shift
    words.each do |wd|
      wd = "0" + wd if wd.length == 1
      wd = "00" if wd.nil?
      aft_pos = aft_pos + wd
    end
    aft_pos = fs_wd + "." + aft_pos
    return aft_pos.to_f
  end

  # 日本緯度・経度から世界測地系の緯度を算出
  def self.change_pos_x(pos_x, pos_y)
    val = 0
    #val = pos_x - pos_x * 0.00010695 + pos_y * 0.000017464 + 0.0046017
    val = pos_x
    return val
  end
  # 日本緯度・経度から世界測地系の経度を算出
  def self.change_pos_y(pos_x, pos_y)
    val = 0
    #val = pos_y - pos_x * 0.000046038 - pos_y * 0.000083043 + 0.01004
    val = pos_y
    return val
  end
end