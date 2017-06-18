require 'bundler'
require 'roda'
require 'sqlite3'
require 'sequel'
require 'httparty'
require 'json'

DB = Sequel.connect('sqlite://database.sqlite3')

class Account < Sequel::Model
  plugin :json_serializer

end

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
              address = r.params["address"]
              response = HTTParty.get("https://etherchain.org/api/account/#{address}")
              set_balance(response, address)
            end
          end
        end
      end
    end

    def set_balance(response, address)
      body = JSON.parse(response.body)
      if body['status'] == 1 && body['data'].any?
        data    = body['data'].first
        balance = "#{data['balance']}"
        Account.insert(address: address, balance: balance)
        { status: :success }
      else
        { status: :error }
      end
    end

    def get_accounts
      Account.all
    end
  end
end
