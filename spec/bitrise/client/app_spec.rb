RSpec.describe Bitrise::Client::Build do
  let(:client) { Bitrise::Client.new(access_token: "access_token") }
  let(:query) { {} }

  before do
    stub_request(:get, "https://api.bitrise.io/v0.1/apps").
      with(query: query).
      to_return(status: response_code, body: response.to_json)
  end

  describe '#apps' do
    context "when request succeeded" do
      let(:query) { { sort_by: "created_at" } }
      let(:response_code) { 200 }
      let(:response) do
        {
          data: [{
            slug: "xxxxxxxxxxxxxxxx",
            title: "bitrise-client",
            project_type: "other",
            provider: "github",
            repo_owner: "mataku",
            repo_url: "git@github.com/mataku/bitrise-client.git",
            repo_slug: "bitrise-client",
            is_disabled: true,
            status: 1,
            is_public: true,
            is_github_checks_enabled: false,
            owner: {
              account_type: "user",
              name: "mataku",
              slug: "yyyyyyyyyyyyyyyy"
            },
            avatar_url: "https://example.com/avatar.png",
          }],
          paging: {
            total_item_count: 1,
            page_item_limit: 50,
            next: "zzzzzzzzzzzzzzzz",
          }
        }
      end

      it 'returns AppResponse' do
        result = client.apps(sort_by: "created_at")

        expect(result.data).to match([have_attributes(
          slug: "xxxxxxxxxxxxxxxx",
          title: "bitrise-client",
          project_type: "other",
          provider: "github",
          repo_owner: "mataku",
          repo_url: "git@github.com/mataku/bitrise-client.git",
          repo_slug: "bitrise-client",
          is_disabled: true,
          status: 1,
          is_public: true,
          is_github_checks_enabled: false,
          avatar_url: "https://example.com/avatar.png",
        )])
        expect(result.data.first.owner).to have_attributes(
          account_type: "user",
          name: "mataku",
          slug: "yyyyyyyyyyyyyyyy",
        )
        expect(result.paging).to have_attributes(
          total_item_count: 1,
          page_item_limit: 50,
          next: "zzzzzzzzzzzzzzzz",
        )
      end
    end
  end

  context "when request failed" do
    let(:response_code) { 422 }
    let(:response) do
      { message: "Error" }
    end

    it do
      expect { client.apps }.to raise_error(Bitrise::Error)
    end
  end
end
