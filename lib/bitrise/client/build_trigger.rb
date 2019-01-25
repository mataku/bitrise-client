module Bitrise
  class Client
    module Build
      def trigger(app_slug, options = {})
        raise ArgumentError.new('App slug required')
      end
    end
  end
end
