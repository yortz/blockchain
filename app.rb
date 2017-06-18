require 'bundler'
require 'roda'

module Blockchain
  class App < Roda
    plugin :json, classes: [Array, Hash]
    route do |r|
      r.on "api" do
        r.on "v1" do
          r.is "accounts" do
            r.get do
              {accounts: :get_accounts}
            end
            r.post do
              {accounts: r.params["address"]}
            end
          end
        end
      end
    end
  end
end
