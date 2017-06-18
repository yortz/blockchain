require 'spec_helper'
describe Blockchain::App, roda: :app do
  describe '#GET /accounts' do
    before do
      DB = Sequel.mock(:fetch=>[{ id: 1, address: "0x5f862a4adfc4ef14e6c6ee1acaf4838e2a0d34ad", balance: 1989580000000000000}])
      get('/api/v1/accounts')
    end

    it { expect(last_response).to be_successful }
    it "gets a list of accounts" do
      accounts = JSON.parse(last_response.body)["accounts"]
      expect(accounts).not_to be_empty
      expect(accounts.first["id"]).to eq 1
      expect(accounts.first["address"]).to eq  "0x5f862a4adfc4ef14e6c6ee1acaf4838e2a0d34ad"
      expect(accounts.first["balance"]).to eq 1989580000000000000
    end
  end

  describe '#POST /accounts' do
    before { post('/api/v1/accounts', { address: '123456' }) }

    it { expect(last_response).to be_successful }
    it { expect(JSON.parse(last_response.body)).to eq ({ "accounts" => "123456" })}
  end
end

