RSpec.describe Bitrise::Client::Build do
  let(:test_app_slug) { 'test_app_slug' }
  let(:test_build_trigger_token) { 'build_trigger_token' }
  let(:client) { Bitrise::Client.new }

  describe '#trigger' do
    let(:path) { "/app/#{test_app_slug}/build/start.json" }

    let(:response) do
      [
        201,
        {},
        JSON.dump({
          "status"=>"ok",
          "message"=>"Webhook triggered",
          "slug"=>"xxxxxxxxxxxxxxxx",
          "service"=>"bitrise"
        })
      ]
    end

    let(:test_client) do
      Faraday.new do |faraday|
        faraday.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
          stub.post(path) do
            response
          end
        end
      end
    end

    before do
      allow(client).to receive(:client).and_return(test_client)
    end

    it do
      expect(client.trigger(app_slug = test_app_slug, build_trigger_token = test_build_trigger_token)['status']).to eq('ok')
    end
  end
end
