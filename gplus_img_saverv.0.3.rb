require "watir-webdriver"
require "open-uri"

@urls_albums_array = File.read("albums.txt").split(/\n/)
@urls_events_array = File.read("events.txt").split(/\n/)
@urls_array = @urls_albums_array.count + @urls_events_array.count
@year, @month, @day = Date.today.strftime("%Y,%m,%d").split(",")
@b = Watir::Browser.new :ff #FireFox
#@b = Watir::Browser.new :phantomjs #Headless!

def counter(c_cls)
  @i = @b.imgs(:class, c_cls).count
  @b.send_keys :end 
  @k = @b.imgs(:class, c_cls).count
  @b.send_keys :end
end

def img_counter(cls, c_cls, name)
	counter(c_cls)
	puts "Counting ..."
		while @i.to_i != @k.to_i do
			counter(c_cls)
		end
	puts @i.to_s+" images in the photo album "+@album.to_s+" .."		
	@images = []
	@b.imgs(:class, cls).each do |y|
		if y.src == "" or y.src == " " or y.src.empty? or y.src == "/" or y.src == "/\/" then
		  next
		end
	@images.push(y.src)
	end
end

def write_images
	for u in 0..@images.count-1 do
			x = @images[u].split("/")
			y = x[0].replace("http:")		
			z = x[7].replace("s0-d")
			@img[u] = x.join(" ").gsub(" ","/")
		#	puts @img[u]
		File.open("#{@dir}/#{@year}-#{@month}-#{@day}-#{u}.jpg", 'wb') do |f|
			f.write open(@img[u]).read
			puts "Saving file " + @img[u] + " ..." 
		end
	end
end

if @urls_events_array != 0 then @urls_events_array.each do |url|
	@b.goto url 
	@album = @b.div(:class, "Iba").text.to_s.gsub(/\\|\/|\*|\]|\[|\)|\(|.\?|.>|.<|\||\"|\'|\,|\:|:|\n|\+/,"")
	@b.div(:class, "uZa PKb").click
	sleep 2
	@author = @b.a(:class, "Sg Ob FdhYye").text.gsub(/\\|\/|\*|\]|\[|\)|\(|.\?|.>|.<|\||\"|\'|\,|\:|:|\n|\+/,"")
	@x = @b.imgs(:class, "ev aG").each.count.to_i
	@y = @b.imgs(:class, "m-la-Kb-Z").each.count.to_i
		if @x>0 and @y>0
		img_counter("ev aG", "ev aG", "event_counter")
		img_counter("m-la-Kb-Z", "m-la-Kb-Z", "event_counter")
		elsif @x>0 and @y<=0 
		img_counter("ev aG", "ev aG", "event_counter")
		elsif @x<=0 and @y>0
		img_counter("m-la-Kb-Z", "m-la-Kb-Z", "event_counter")
		else p "Event albums have no photos ... Here be dragons.. :)"
		end
	@img = Array.new
  @dir = "images/"+@author+"/"+@album
	FileUtils::mkdir_p(@dir)
	write_images
	end
else puts "Please add some links to your events.txt file in the format https://plus.google.com/events/<string>"
end

if @urls_albums_array.count != 0 then @urls_albums_array.each do |url|
	@b.goto url 
	@album = @b.div(:class, "Mqa WauR1d").text.to_s.gsub(/\\|\/|\*|\]|\[|\)|\(|.\?|.>|.<|\||\"|\'|\,|\:|:|\n|\+/,"")
	@author = @b.div(:class, "og c-b c-b-T a-f-e Nwa yka").text.split(" ")[2,3].to_s.gsub(/\\|\/|\*|\]|\[|\)|\(|.\?|.>|.<|\||\"|\'|\,|\:|:|\n|\+/,"")
	img_counter("tDMXke", "tDMXke", "photo albums counter")
	@img = Array.new
	@dir = "images/"+@author+"/"+@album
	FileUtils::mkdir_p(@dir)
	write_images
	end
else puts "Please add some links to your albums.txt file in the format https://plus.google.com/photos/<string>/albums/<string>"
end
@b.close

#======== #in_dev #========
#Things to add::
# - pic filename recorder -
# - comments exporter -
# - detection of event photos and album photos ++

def get_batch_user_albums_data
	@b.div(:xpath, "/html/body/div[2]/div[3]/div[5]/div/div[3]/div[2]/div/div/div/div/div/div/div[3]/div/div[2]").click #Альбомы
	for i in 0..@b.divs(:class, "jwD3Ob").count { |a| @user_albums.push(a.text) }; end
	for i in 0..@b.divs(:class, "onSq9d").count { |a| @album_dates.push(a.text.split(" ")[2]) }; end
	for i in 0..@b.as(:class, "PkkLkd A4Ufz FW9qdb").count { |a| @album_links.push(a.href) }; end
		h = Hash.new
			for i in 0..@user_albums.count-1 do
			h[i] = [ "date"[i] => @album_dates[i], "name"[i] => @user_albums[i], "link"[i] =>  @album_links[i] ]  
			puts h[i]
		end
end
