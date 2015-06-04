require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'

@filename = "avito.csv"

def download_image(uri, images_name)
  open("http://#{uri}") {|f|
    File.open("images/#{images_name}","wb") do |file|
      file.puts f.read
    end
  }
end

def find_image_link page
  images = page.css('.big-picture img')
  images_link = nil
  images_name = nil
  if images.length > 0
    images_link = images[0]['src'].sub(/^\/\//, '')
    images_name = URI(images_link).path.split('/').last
    puts "#{images_name}"
    puts "image => #{images_link}"
    download_image images_link, images_name
  end
  images_name
end

def find_uslugi_image_link page
  images = page.css('a.gallery-link')
  images_name = nil
  if images.length > 0
    images_link = images[0]['data-fallback'].sub(/^\/\//, '')
    images_name = URI(images_link).path.split('/').last
    puts "#{images_name}"
    puts "image => #{images_link}"
    download_image images_link, images_name
  end
  images_name
end

def crawl_page(url, category)
  page = Nokogiri::HTML(open(url))
  links = page.css('.description h3.title a')

  puts links.length

  links.each do |link|
    title = link['title']
    link_link = link['href']

    puts link_link

    link_page = Nokogiri::HTML(open("https://www.avito.ru#{link_link}"))
    desc = link_page.css('#desc_text').text

    images_name = if category == "Услуги"
      find_uslugi_image_link link_page
    else
      find_image_link link_page
    end

    price = 0
    price_text = link_page.css("span[itemprop='price']").text.gsub(/\D/, '')
    if price_text.length > 0
      price = price_text.to_i
    end

    name = link_page.css("strong[itemprop='name']").text

    CSV.open(@filename, "ab") do |csv|
      csv << [images_name,price,category,desc,name.strip,""]
    end
  end

  next_page = "https://avito.ru" + page.css('.pagination__nav a.pagination__page')[0]['href']

  return next_page, links.length
end

def crawl_category(uri, category)
  total = 0
  next_page = uri
  while total < 1000
    next_page, loaded = crawl_page next_page, category
    total += loaded
    puts "loaded total #{total}"
  end
end

start_time = Time.now

#CSV.open(@filename, "wb") do |csv|
#  csv << ["Фото","Цена","Категория","Описание","Имя","Телефон"]
#end

uri_category = {
#    "Бытовая техника" => "https://www.avito.ru/moskva/bytovaya_elektronika",
#    "Для дома и дачи" => "https://www.avito.ru/moskva/dlya_doma_i_dachi",
#    "Обувь" => "https://www.avito.ru/moskva/odezhda_obuv_aksessuary/zhenskaya_odezhda/obuv",
#    "Одежда" => "https://www.avito.ru/moskva/odezhda_obuv_aksessuary/zhenskaya_odezhda",
#    "Ремонт и строительство" => "https://www.avito.ru/moskva/remont_i_stroitelstvo",
#    "Транспорт" => "https://www.avito.ru/moskva/transport",
    "Услуги" => "https://www.avito.ru/moskva/uslugi"
#    "Хобби и отдых" => "https://www.avito.ru/moskva/hobbi_i_otdyh"
}

uri_category.each do |category, uri|
  crawl_category uri, category
end

puts "Current Time : " + start_time.inspect

end_time = Time.now
puts "End time: " + end_time.inspect
puts (end_time - start_time).to_i
