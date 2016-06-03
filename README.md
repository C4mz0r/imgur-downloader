# imgur-downloader
Download from imgur when /zip doesn't work

There's a trick out there where you can tack on /zip to the end of an imgur gallery URL and download the whole thing as a zip.

However, sometimes it just doesn't work.

This script can be used to download the files instead if /zip doesn't work.

How to use it:
- Find a gallery that you want to download (e.g. the format should be imgur.com/gallery/<gallery_name>)
- Run the program and when prompted, provide the url in the format above.
- The program will create a random directory and download the photos in order, numbering them.

Currently:
Limited to jpg.
Is case sensitive.

I've only used it on Ubuntu so far.

Requires selenium webdriver, if you don't have it you can run the command:
gem install selenium-webdriver