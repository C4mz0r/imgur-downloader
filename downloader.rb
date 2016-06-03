require 'selenium-webdriver' # gem install selenium-webdriver
require 'net/http'

def convertToGridView(url)
  if url =~ /(\S*)\/gallery\/(\S*)/
    gridUrl = "#{$1}/a/#{$2}/layout/grid"
  else
    raise "gallery not found"
  end    
end

def downloadFile(url, number)  
  url =~ /http:\/\/(\S*)\/(\S*)/  
  Net::HTTP.start($1) do |http|
    resp = http.get($2)
    open("#{number}_#{$2}", "wb") do |file|
        file.write(resp.body)
    end
  end
end

print "Enter the gallery URL: "
galleryUrl = gets
 
driver = Selenium::WebDriver.for :firefox
driver.navigate.to convertToGridView galleryUrl
  
elements = driver.find_elements(:css, "div.panel a")

newDirectory = ('a'..'z').to_a.shuffle[0,7].join 
Dir.mkdir newDirectory
Dir.chdir newDirectory

elements.select {|e| e.attribute(:href).include? ".jpg"}.each_with_index do |elem, i|
  theUrl = elem.attribute(:href)
  downloadFile theUrl, "%03d" % i
end

driver.quit


