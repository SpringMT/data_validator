# encoding: UTF-8

module DataValidator
  class AcceptanceValidator < BaseValidator
    def initialize(name, value, options, errors)
      raise ArgumentError, 'Options must define' unless options
      case options
      when Hash
        options_base = options
      else
        options_base = {}
      end
      super(name, value, options_base.reverse_merge(:allow_nil => true, :accept => "1"), errors)
    end

    def validate
      unless value == options[:accept]
        add_error :accepted
      end
    end

  end
end


