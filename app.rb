require 'bundler'
require 'roda'
require 'sqlite3'
require 'sequel'
require 'httparty'
require 'json'

env = ENV['RACK_ENV']


DB = Sequel.connect("sqlite://database_#{env}.sqlite3")

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

            # curl --request GET 'http://blockchain.dev/api/v1/accounts' --include
            r.get do
              {accounts: get_accounts}
            end

            # curl --request POST "http://blockchain.dev/api/v1/accounts" --data "address=0x8eeec35015baba2890e714e052dfbe73f4b752f9"
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
      Account.all.map { |a| a.values.merge(wei: a[:balance] * 1000000000000000000)  }
    end
  end
end
