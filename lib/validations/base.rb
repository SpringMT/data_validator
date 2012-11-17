# encoding: UTF-8

require 'i18n'

module DataValidator
  class BaseValidator
    attr_accessor :name, :value, :options, :errors
    def initialize(name, value, options, errors)
      raise ArgumentError, "options must define" unless options

      case options
      when Hash
        @options = options
      else
        @options = {}
      end

      @name    = name
      @value   = value
      @errors  = errors
    end
    def check_validity!
    end
    def validate
      raise ArgumentError, "validate method is necessary"
    end
    def error_add(error_message_key, message_args = {})
      if errors.key? name
        errors[name] << I18n.t("errors.messages.#{error_message_key.to_s}", message_args)
      else
        errors[name] = [I18n.t("errors.messages.#{error_message_key.to_s}", message_args)]
      end
    end
  end
end


