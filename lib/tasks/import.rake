require 'csv'

def csv_to_hash(filename)
  csv_data = CSV.read "#{::Rails.root}/lib/tasks/import_csvs/#{filename}"
  headers = csv_data.shift.map do |i|
    i = i.to_s
    if i =~ /\./
      slices = i.split(".")
      header = slices.last
    else
      header = i
    end
    header
  end
  string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
  array_of_hashes = string_data.map {|row| Hashie::Mash.new(Hash[*headers.zip(row).flatten]) }
end

namespace :import do

  desc "Import all"
  task :all => [:users, :forums, :topics, :posts] do
    puts "==> Done!"
  end

  desc "Import Users"
  task :users => :environment do
    ActiveRecord::Base.record_timestamps = false
    User.destroy_all

    users = csv_to_hash("phpbb3_users.csv")

    users.each do |user|

      begin
        user = User.create!({
        username: user.username,
        email: user.user_email,
        admin: user.group_id.to_i == 9,
        password: User.send(:generate_token, 'encrypted_password').slice(0, 6),
        import_id: user.user_id,
        created_at: Time.at(user.user_regdate.to_i),
        updated_at: Time.at(user.user_regdate.to_i)
      })
        user.confirm!
      rescue Exception => e
        puts "ERROR: #{e}"
      end

      print "."
    end

    puts "\nDone! Imported #{User.count} users."
    ActiveRecord::Base.record_timestamps = true
  end

  desc "Import Forums"
  task :forums => :environment do
    Forum.destroy_all
    # forums = csv_to_hash("phpbb3_forums.csv")
    forums = YAML::load(File.open("#{Rails.root}/lib/tasks/import_csvs/phpbb3_forums.yml"))

    forums.each do |forum|
      begin
        Forum.create!({
          name: forum["forum_name"],
          description: forum["forum_desc"],
          import_id: forum["forum_id"]
        })
      rescue Exception => e
        puts "\n#{e}\n"
      end
      print "."
    end

    puts "\nDone! Imported #{Forum.count} forums."
  end

  desc "Import Topics"
  task :topics => :environment do
    ActiveRecord::Base.record_timestamps = false

    Topic.destroy_all
    # topics = csv_to_hash("phpbb3_topics.csv")
    topics = YAML::load(File.open("#{Rails.root}/lib/tasks/import_csvs/phpbb3_topics.yml"))

    topics.each do |topic|
      begin
        Topic.create!({
          title: topic["topic_title"],
          user_id: User.find_by_import_id(topic["topic_poster"]).id,
          views: topic["topic_views"],
          posts_count: topic["topic_replies"],
          forum_id: Forum.find_by_import_id(topic["forum_id"]).id,
          import_id: topic["topic_id"],
          created_at: Time.at(topic["topic_time"].to_i),
          updated_at: Time.at(topic["topic_last_post_time"].to_i)
        })
      rescue Exception => e
        puts "====="
        puts "ERROR: #{e}, Topic id: #{topic["topic_id"]}, Forum id: #{topic["forum_id"]}"
        puts "====="
      end
      print "."
    end

    puts "\nDone! Imported #{Topic.count} topics."
    ActiveRecord::Base.record_timestamps = true

  end

  desc "Import Posts"
  task :posts => :environment do
    ActiveRecord::Base.record_timestamps = false

    Post.destroy_all
    posts = YAML::load(File.open("#{Rails.root}/lib/tasks/import_csvs/phpbb3_posts.yml"))

    posts.each do |post|
      begin
        Post.create!({
          topic_id: Topic.find_by_import_id(post["topic_id"]).id,
          user_id: User.find_by_import_id(post["poster_id"]).id,
          content: post["post_text"],
          created_at: Time.at(post["post_time"].to_i),
          updated_at: Time.at(post["post_time"].to_i),
          import_id: post["post_id"]
        })
      rescue Exception => e
        puts "==> \n#{e}\n"
      end
      print "."
    end

    puts "\nDone! Imported #{Post.count} posts."
    ActiveRecord::Base.record_timestamps = true

  end

end