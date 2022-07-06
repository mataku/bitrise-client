module Bitrise
  class Response
    def initialize(json)
      @json = json
    end
  end

  class Paging
    attr_reader :total_item_count, :page_item_limit, :next

    def initialize(attrs = {})
      @total_item_count = attrs['total_item_count']
      @page_item_limit = attrs['page_item_limit']
      @next = attrs['next']
    end
  end

  module Pagination
    def paging
      ::Bitrise::Paging.new(@json["paging"])
    end
  end
end
