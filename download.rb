load 'downloader.rb'

# list galleries to download here
galleries = ["http://imgur.com/gallery/LiL8I"]

# loop through each and download into the specified parent folder
galleries.each do |g|
  dl = Downloader.new g, "/home/yourName/Downloads"
  dl.downloadGallery
end

