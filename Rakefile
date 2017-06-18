require 'sqlite3'
require 'sequel'

namespace :db do
  desc 'Bootstraps DB'
  task :bootstrap do
   `sequel -m db/migrations sqlite://database.sqlite3`
  end
end

