require 'spec_helper'
describe Blockchain::App, roda: :app do
  describe '#GET /accounts' do
    before { get('/api/v1/accounts') }

    it { expect(last_response).to be_successful }
    it { expect(JSON.parse(last_response.body)).to eq ({ "accounts" => "get_accounts" })}
  end

  describe '#POST /accounts' do
    before { post('/api/v1/accounts', { address: '123456' }) }

    it { expect(last_response).to be_successful }
    it { expect(JSON.parse(last_response.body)).to eq ({ "accounts" => "123456" })}
  end
end

