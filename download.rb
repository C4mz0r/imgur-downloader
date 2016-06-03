load 'downloader.rb'

# list galleries to download here
galleries = ["http://imgur.com/a/LiL8I/"]

# loop through each and download into the specified parent folder
galleries.each do |g|
  dl = Downloader.new g, "/home/c4mz0r/Downloads"
  dl.downloadGallery
end

