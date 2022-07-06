module Bitrise
  class AppOwner
    attr_reader :account_type, :name, :slug

    def initialize(attrs = {})
      @account_type = attrs['account_type']
      @name = attrs['name']
      @slug = attrs['slug']
    end
  end
end
