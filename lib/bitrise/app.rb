require "bitrise/response"
require "bitrise/app_owner"

module Bitrise
  class AppResponse < Response
    include Pagination

    def data
      @json.fetch("data")&.map do |raw|
        App.new(raw)
      end
    end
  end

  class App
    attr_reader :slug, :title, :project_type, :provider, :repo_owner, :repo_url, :repo_slug, :is_disabled, :status, :is_public, :is_github_checks_enabled, :owner, :avatar_url

    def initialize(attrs = {})
      @slug = attrs['slug']
      @title = attrs['title']
      @project_type = attrs['project_type']
      @provider = attrs['provider']
      @repo_owner = attrs['repo_owner']
      @repo_url = attrs['repo_url']
      @repo_slug = attrs['repo_slug']
      @is_disabled = attrs['is_disabled']
      @status = attrs['status']
      @is_public = attrs['is_public']
      @is_github_checks_enabled = attrs['is_github_checks_enabled']
      @owner = AppOwner.new(attrs['owner'])
      @avatar_url = attrs['avatar_url']
    end
  end
end
