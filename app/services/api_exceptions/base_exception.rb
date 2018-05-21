module ApiExceptions
  class BaseException < StandardError
    include ActiveModel::Serialization
    attr_reader :status

    def initialize(msg)
      super(msg)
    end
  end
end
