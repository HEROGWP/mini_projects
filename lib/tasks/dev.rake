namespace :dev do
desc "重建一些假資料"
	task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate"]
  task :rebuild => ["dev:build" , :fake]
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

	      puts "create video id is #{@video.id}"
    	end
    end
    User.create(email: "test@gmail.com", password: "12345678", password_confirmation: "12345678")
    User.create(email: "pp820819@gmail.com", password: "12345678", password_confirmation: "12345678")
    User.create(email: "iamcute@gmail.com", password: "12345678", password_confirmation: "12345678")

    
    for i in 1..5 do
    	@category = Category.create(name: Faker::Beer.style)
    	puts "create category id is #{@category.name}"
    end
    
    for user in 1..3 do
    	for topic in 1..5 do
    		category_ids = []
	    	for category_id in 1..5 do	
		    	if [true, false].sample
		    		category_ids << category_id
		    	end
		    	#puts category_ids
		    end
	    	@topic = User.find(user).topics.create(title: Faker::Beer.name, content: Faker::Lorem.paragraph, category_ids: category_ids, status: "published")
		  	puts "create topic id is #{@topic.title}"
		  	User.find(user).topics.each do |topic|
		  		5.times do
		  			@comment = topic.comments.build(content: Faker::Lorem.paragraph, status: "published" )
		  			@comment.user_id = user
		  			@comment.save
		  			puts "create comment id is #{@comment.id}"
		  		end
		  	end
		  end


    end

  end
end
