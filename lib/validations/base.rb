# encoding: UTF-8

module FormValidator
  class BaseValidation
    attr_accessor :key, :value, :options, :errors
    def initialize(key, value, options, errors)
      @key     = key
      @value   = value
      @options = options
      @errors  = errors
    end
    def valid?
    end
  end
end


