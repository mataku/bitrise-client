module Bitrise
  class TestDevice
    attr_accessor :device_id, :device_type, :owner

    def initialize(attrs = {})
      @device_id = attrs['device_id']
      @device_type = attrs['device_type']
      @owner = attrs['owner']
    end
  end
end
