namespace :dev do
desc "重建一些假資料"
  task :rebuild => ["db:reset" , :fake]
  task :fake => :environment do
    for i in 1..20 do
      @video = Video.new(:name => Faker::Name.name , :description => Faker::Hipster.paragraph, :url_address => Faker::Internet.url, :times => 0)
      @video[:random] = SecureRandom.hex(5)
      @video.save

      puts "create event id is #{@video.id}"
    end
  end

end
