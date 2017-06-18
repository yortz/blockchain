require 'sqlite3'
require 'sequel'

namespace :db do
  desc 'Bootstraps DB'
  task :bootstrap do
    ["test", "development"].each do |env|
      `sequel -m db/migrations sqlite://database_#{env}.sqlite3`
    end
  end
end

