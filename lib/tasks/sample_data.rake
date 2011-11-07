require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:first_name => "User",
                 :last_name  => "Example",
                 :email      => "user@example.com",
                 :password   => "foobar",
                 :password_confirmation => "foobar")
    99.times do |n|
      first_name = Faker::Name.first_name
      last_name  = Faker::Name.last_name
      email      = "user-#{n+1}@example.com"
      password   = "foobar"
      User.create!(:first_name => first_name,
                   :last_name  => last_name,
                   :email      => email,
                   :password   => password,
                   :password_confirmation => password)
    end
  end
end
