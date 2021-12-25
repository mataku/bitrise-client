RSpec.describe Bitrise::Client::Build do
  let(:app_slug) { 'test_app_slug' }
  let(:client) { Bitrise::Client.new(access_token: 'access_token') }

  describe '#trigger_build' do
    let(:path) { "/v0.1/apps/#{app_slug}/builds" }

    let(:response) do
      [
        201,
        {},
        JSON.dump({
          "status"=>"ok",
          "message"=>"Webhook triggered",
          "slug"=>"xxxxxxxxxxxxxxxx",
          "service"=>"bitrise",
          "triggered_workflow"=>'primary',
          "build_number"=>1,
          "build_slug"=>"1234567a-abc1-abc1-abc1-1234567890ab",
          "build_url"=>"https://app.bitrise.io/build/1234567a-abc1-abc1-abc1-1234567890ab"
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

    let(:build_params) do
      {
        branch: 'develop'
      }
    end

    before do
      allow(client).to receive(:client).and_return(test_client)
    end

    context 'request succeeded' do
      it 'returns BuildTriggerResult' do
        result = client.trigger_build(app_slug: app_slug, build_params: build_params)
        expect(result.status).to eq('ok')
        expect(result.message).to eq('Webhook triggered')
        expect(result.slug).to eq('xxxxxxxxxxxxxxxx')
        expect(result.service).to eq('bitrise')
        expect(result.triggered_workflow).to eq('primary')
        expect(result.build_number).to eq(1)
        expect(result.build_slug).to eq('1234567a-abc1-abc1-abc1-1234567890ab')
        expect(result.build_url).to eq('https://app.bitrise.io/build/1234567a-abc1-abc1-abc1-1234567890ab')
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

      it do
        expect { client.trigger_build(app_slug: app_slug, build_params: build_params) }.to raise_error(Bitrise::Error)
      end
    end

    context 'app_slug is missing' do
      let(:error_message) do
        "App slug required. You must specify by 'app_slug:'"
      end

      it do
        expect { client.trigger_build(build_params: build_params) }.to raise_error(ArgumentError, error_message)
      end

    end

    context 'build_params id empty' do
      let(:error_message) do
        "No value found for 'branch' or 'tag' or 'workflow_id'"
      end

      it do
        expect { client.trigger_build(app_slug: app_slug) }.to raise_error(ArgumentError, error_message)
      end
    end
  end
end
