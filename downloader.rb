require 'selenium-webdriver' # gem install selenium-webdriver
require 'net/http'

class Downloader
  
  def initialize(url, baseSaveFolder = nil)    
    @url = url
    @baseSaveFolder = baseSaveFolder
    process @url # parses the given url and sets other member variables
    @browser = :firefox
  end
  
  def downloadGallery
    prepareDirectory ('a'..'z').to_a.shuffle[0,7].join
    launchBrowser
    downloadImages
    @driver.quit 
  end
  
  private
    def process url
      if url =~ /(\S*)\/gallery\/(\S*)/i
        @http_host = $1
        @gallery_name = $2
        @grid_url = "#{$1}/a/#{$2}/layout/grid"
      elsif url =~ /(\S*)\/a\/(\S*)/i
        @http_host = $1
        @gallery_name = $2
        @grid_url = "#{$1}/a/#{$2}/layout/grid"
      else
        raise "gallery not found"
      end  
    end
    
    def downloadFile url, prefix
      url =~ /http:\/\/(\S*)\/(\S*)/ 
      Net::HTTP.start($1) do |http|
        resp = http.get($2)
        open("#{prefix}_#{$2}", "wb") do |file|
          file.write(resp.body)
        end
      end
    end
    
    def launchBrowser
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile['browser.privatebrowsing.autostart'] = true
      @driver = Selenium::WebDriver.for :firefox, :profile => profile
      @driver.navigate.to @grid_url      
    end
    
    def downloadImages
      elements = @driver.find_elements(:css, "div.panel a")
      elements.select {|e| e.attribute(:href).include? ".jpg"}.each_with_index do |elem, i|
        theUrl = elem.attribute(:href)
        downloadFile theUrl, "%03d" % i
      end
    end
    
    def prepareDirectory dir
      newDir = dir
      if (!@baseSaveFolder.nil?)
        newDir = File.join(@baseSaveFolder, dir)  
      end
    
      puts "Trying to create a new directory to save data: #{newDir}"  
      Dir.mkdir newDir
      Dir.chdir newDir
    end
  
end
