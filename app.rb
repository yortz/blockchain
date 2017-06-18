require 'bundler'
require 'roda'
module Blockchain
  class App < Roda
    plugin :json, classes: [Array, Hash]
    route do |r|
      r.get do
        r.on "hello" do
          {hello: :world}
        end
      end

      r.post do
        r.on "create" do
          {params: r.params}
        end
      end
    end
  end
end
