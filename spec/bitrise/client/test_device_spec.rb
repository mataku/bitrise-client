RSpec.describe Bitrise::Client::TestDevice do
  let(:app_slug) { 'test_app_slug' }
  let(:client) { Bitrise::Client.new(access_token: 'access_token') }
  let(:path) { "/v0.1/apps/#{app_slug}/test-devices" }
  let(:test_client) do
    Faraday.new(url: 'https://api.bitrise.io') do |faraday|
      faraday.use Bitrise::Client::Middleware::ErrorHandler
      faraday.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get(path) do
          response
        end
      end
    end
  end

  before do
    allow(client).to receive(:client).and_return(test_client)
  end

  describe '#test_devices' do
    context 'request succeeded' do
      let(:response) do
        [
          200,
          {},
          JSON.dump({
            "data" => [
             {
                "device_id"=>"device_id",
                "device_type"=>"device_type",
                "owner"=>"mataku"
              },
              {
                "device_id"=>"device2_id",
                "device_type"=>"device2_type",
                "owner"=>"mataku"
              }
            ]
          })
        ]
      end

      it 'returns array of TestDevice' do
        result = client.test_devices(app_slug: app_slug)
        expect(result.size).to eq(2)
        result.each do |device|
          expect(device.device_id.empty?).to eq(false)
          expect(device.device_type.empty?).to eq(false)
          expect(device.owner.empty?).to eq(false)
        end
      end
    end

    context 'request failed' do
      let(:error_message) { 'something wrong' }
      let(:response) do
        [
          422,
          {},
          JSON.dump({'message'=>error_message})
        ]
      end

      it 'raises Bitrise::Error' do
        expect { client.test_devices(app_slug: app_slug) }.to raise_error(Bitrise::Error, error_message)
      end
    end
  end
end
