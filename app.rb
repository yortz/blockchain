require 'bundler'
require 'roda'
require 'sqlite3'
require 'sequel'

DB = Sequel.connect('sqlite://database.sqlite3')

module Blockchain
  class App < Roda
    plugin :json, classes: [Array, Hash]
    route do |r|
      r.on "api" do
        r.on "v1" do
          r.is "accounts" do
            r.get do
              {accounts: get_accounts}
            end
            r.post do
              {accounts: r.params["address"]}
            end
          end
        end
      end
    end

    def get_accounts
      DB[:accounts].all
    end
  end
end
