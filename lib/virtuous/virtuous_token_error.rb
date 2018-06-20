module Virtuous
  class VirtuousTokenError < StandardError
    attr_reader :data

    def initialize(data)
      super
      @data = data
    end
  end
end
