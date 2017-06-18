require 'spec_helper'

describe Blockchain::App, roda: :app do
  describe '/hello' do
    before { get('/hello') }

    it { expect(last_response).to be_successful }
    it { expect(JSON.parse(last_response.body)).to eq ({ "hello" => "world" })}
  end

  describe '/create' do
    before { post('/create', {something: "hello world"}) }

    it { expect(last_response).to be_successful }
    it { expect(JSON.parse(last_response.body)).to eq ({"params"=>{"something"=>"hello world"}})}
  end
end

