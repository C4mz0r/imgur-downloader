# imgur-downloader
Download from imgur when /zip doesn't work

There's a trick out there where you can tack on /zip to the end of an imgur gallery URL and download the whole thing as a zip.

However, sometimes it just doesn't work.

This library can be used to download the files instead if /zip doesn't work.

How to use it:
- Find a gallery that you want to download (e.g. the format should be imgur.com/gallery/gallery_name)
- Instantiate the Downloader class and provide the url in the format above and a download folder.
- The program will create a random directory and download the photos in order, numbering them.

```ruby
load 'downloader.rb'
dl = Downloader.new "http://imgur.com/gallery/LiL8I", "/home/yourName/Downloads"
dl.downloadGallery
```

Currently limited to jpg.

I've only used it on Ubuntu so far.

Requires Firefox and the Selenium webdriver, if you don't have it you can run the command:
gem install selenium-webdriver