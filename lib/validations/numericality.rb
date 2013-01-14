# encoding: UTF-8

module DataValidator
  class NumericalityValidator < BaseValidator
    CHECKS = { :greater_than => :>, :greater_than_or_equal_to => :>=,
               :equal_to => :==, :less_than => :<, :less_than_or_equal_to => :<=,
               :odd => :odd?, :even => :even? }.freeze

    def check_validity!
      keys = CHECKS.keys - [:odd, :even]
      options.slice(*keys).each do |option, option_value|
        next if option_value.is_a?(Numeric) || option_value.is_a?(Proc)
        raise ArgumentError, ":#{option} must be a number, a symbol or a proc"
      end
    end

    def validate
      unless checked_value = parse_raw_value_as_a_number(value)
        add_error :not_a_number
        return
      end

      if options[:only_integer]
        unless checked_value = parse_raw_value_as_an_integer(value)
          add_error :not_an_integer
          return
        end
      end

      options.slice(*CHECKS.keys).each do |option, option_value|
        case option
        when :odd, :even
          unless checked_value.to_i.send(CHECKS[option])
            add_error option
          end
        else
          option_value = option_value.call(record) if option_value.is_a?(Proc)
          unless checked_value.send(CHECKS[option], option_value)
            add_error option, count: option_value
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

