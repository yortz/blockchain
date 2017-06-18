require 'spec_helper'
describe Blockchain::App, roda: :app do
  describe '#GET /accounts' do
    let!(:accounts) { create(:account, address: "0x5f862a4adfc4ef14e6c6ee1acaf4838e2a0d34ad", balance: 1989580000000000000 ) }
    before { get('/api/v1/accounts') }

    it { expect(last_response).to be_successful }
    it "gets a list of accounts" do
      accounts = JSON.parse(last_response.body)["accounts"]
      expect(accounts).not_to be_empty
      expect(accounts.first["address"]).to eq  "0x5f862a4adfc4ef14e6c6ee1acaf4838e2a0d34ad"
      expect(accounts.first["balance"]).to eq 1989580000000000000
    end
  end

  describe '#POST /accounts' do
    context "with valid params" do

      before { post('/api/v1/accounts', { address: "0x5f862a4adfc4ef14e6c6ee1acaf4838e2a0d34ad"}) }

      it { expect(last_response).to be_successful }
      it { expect(JSON.parse(last_response.body)).to eq ({ "status" => "success" })}
      it { expect(Account.all).not_to be_empty }
    end

    context "with invalid params" do
      context "without address" do

        before { post('/api/v1/accounts', { address: ""})}
        it { expect(JSON.parse(last_response.body)).to eq ({ "status" => "error" })}
      end

      context "with invalid address" do

        before { post('/api/v1/accounts', { address: "1234"})}
        it { expect(JSON.parse(last_response.body)).to eq ({ "status" => "error" })}
      end
    end

  end
end

