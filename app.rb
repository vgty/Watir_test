require 'watir'
require 'nokogiri'
require 'open-uri'
#Search terms
search_terms = ["Steve jobs", "Dale Carnegie", "Henry Ford", "Benjamin Franklin", "Thomas Edison"]

#setting phantom Browser
b = Watir::Browser.new(:chrome)
b.goto("images.google.com")

#searching process
search_terms.each do |term|

b.text_field(title: "Rechercher").set term
b.button(type: "submit").click
sleep 1
doc = Nokogiri::HTML.parse(b.html)
link = doc.at_css("div.rg_di img")[:src]

#"downloading file from link"
File.open("./images/#{term}.jpg", "wb") do |file_write|
  open(link, 'rb') do |file_read|
    file_write.write(file_read.read)
  end
end
b.back
end