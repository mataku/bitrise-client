module Bitrise
  class BuildTriggerResult
    attr_accessor :build_number, :build_slug, :build_url, :message, :service, :slug, :status, :triggered_workflow
    def initialize(attrs = {})
      @build_number = attrs['build_number']
      @build_slug = attrs['build_slug']
      @build_url = attrs['build_url']
      @message = attrs['message']
      @service = attrs['service']
      @slug = attrs['slug']
      @status = attrs['status']
      @triggered_workflow = attrs['triggered_workflow']
    end
  end
end
