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
  task :all => :environment do
    puts "==> Done!"
  end

  desc "Import Users"
  task :users => :environment do
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
        created_at: Time.at(user.user_regdate.to_i)
      })
      rescue Exception => e
        puts "====="
        puts "E = #{e}"
        puts "ID = #{user.user_id}"
        if user.errors
          puts "Errors = #{user.errors.full_messages}"
        end
        puts "====="
      end

      print "."
    end

  end

end