# encoding: UTF-8

module DataValidator
  class NumericalityValidator < BaseValidator
    CHECKS = { :greater_than => :>, :greater_than_or_equal_to => :>=,
               :equal_to => :==, :less_than => :<, :less_than_or_equal_to => :<=,
               :odd => :odd?, :even => :even? }.freeze

    def check_validity!
      keys = CHECKS.keys - [:odd, :even]
      options.slice(*keys).each do |option, value|
        next if value.is_a?(Numeric) || value.is_a?(Proc)
        raise ArgumentError, ":#{option} must be a number, a symbol or a proc"
      end
    end

    def validate
      unless checked_value = parse_raw_value_as_a_number(value)
        error_add MESSAGES[key], check_value
        return
      end

      if options[:only_integer]
        unless checked_value = parse_raw_value_as_an_integer(checked_value)
          error_add :not_an_integer, value: checked_value
          return
        end
      end

      options.slice(*CHECKS.keys).each do |option, option_value|
        case option
        when :odd, :even
          unless checked_value.to_i.send(CHECKS[option])
            error_add option, value: checked_value
          end
        else
          option_value = option_value.call(record) if option_value.is_a?(Proc)

          unless checked_value.send(CHECKS[option], option_value)
            error_add option, count: checked_value
          end
        end
      end
    end

    protected
    def parse_raw_value_as_a_number(value)
      case value
      when /\A0[xX]/
        nil
      else
        begin
          Kernel.Float(value)
        rescue ArgumentError, TypeError
          nil
        end
      end
    end

    def parse_raw_value_as_an_integer(value)
      value.to_i if value.to_s =~ /\A[+-]?\d+\Z/
    end

  end
end

