namespace :db do
  desc "Reseed database"
  task :reseed => :environment do
    Rake::Task['db:remigrate'].invoke
    Rake::Task['db:seed'].invoke
  end
  namespace :test do
    task :prepare do
    end
  end

  desc 'Remigrate the database'
  task remigrate: :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke
  end
end 
