RSpec.describe Bitrise::Client::Build do
  let(:test_app_slug) { 'test_app_slug' }
  let(:test_access_token) { 'access_token' }
  let(:client) { Bitrise::Client.new }

  describe '#trigger_build' do
    let(:path) { "/v0.1/apps/#{test_app_slug}/builds" }

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
      Faraday.new(url: 'https://api.bitrise.io') do |faraday|
        faraday.use Bitrise::Client::Middleware::ErrorHandler
        faraday.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
          stub.post(path) do
            response
          end
        end
      end
    end

    context 'request succeeded' do
      before do
        allow(client).to receive(:client).and_return(test_client)
      end

      it do
        expect(client.trigger_build(app_slug = test_app_slug, access_token = test_access_token)['status']).to eq('ok')
      end
    end

    context 'request failed' do
      let(:response) do
        [
          422,
          {},
          JSON.dump({
            "message"=>"Error",
          })
        ]
      end

      before do
        allow(client).to receive(:client).and_return(test_client)
      end

      it do
        expect { client.trigger_build(app_slug = test_app_slug, access_token = test_access_token) }.to raise_error(Bitrise::Error)
      end
    end
  end
end
