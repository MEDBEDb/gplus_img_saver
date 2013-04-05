gplus_img_saver
===============

Ruby based Google+ images (from events and photo-albums) parser based on watir-webdriver and open-uri frameworks.

Instructions
===============
1. Install Ruby 1.9.3
2. gem update --system
3. gem install watir-webdriver
4. Add URL of photo albums and event albums to files albums.txt and events.txt in the format 'https://plus.google.com/events/string' (for events albums) or in the format 'https://plus.google.com/photos/string/albums/string' (for photo albums)
5. run "ruby gplus_img_saver.rb"

It will create a separate folder for each album and save all images, in the format Author/Album/timestamp_n.jpg

Have fun :)

Copyright (c) 2013 MEDBEDb.
=========================
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
