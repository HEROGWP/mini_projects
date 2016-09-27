namespace :dev do
desc "重建一些假資料"
  task :rebuild => ["db:reset" , :fake]
  task :fake => :environment do
    for i in 0..5 do
    	doc = Nokogiri::HTML(open("http://www.xvideos.com/best/#{i}/"))
    	for j in 75..94 do
		  	url = "http://www.xvideos.com" + doc.css('a')[j]['href']
		  	name = doc.css('a')[j].children
		  	description = doc.css('a')[j]['title']
	  	
	      @video = Video.new(:name => name , :description => description, :url_address => url, :times => 0)
	      @video[:random] = SecureRandom.hex(5)
	      @video.save

	      puts "create event id is #{@video.id}"
    	end
    end
  end
end
