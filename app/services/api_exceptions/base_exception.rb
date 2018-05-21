module ApiExceptions
  class BaseException < StandardError
    include ActiveModel::Serialization
    attr_reader :status

    def initialize(msg, status)
      @status = status
      super(msg)
    end
  end
end
