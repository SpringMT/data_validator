# encoding: UTF-8

module DataValidator
  class InclusionValidator < BaseValidator
    ERROR_MESSAGE = 'An object with the method #include? or a proc or lambda is required, ' <<
                      'and must be supplied as the :in option of the configuration hash'

    def check_validity!
      unless [:include?, :call].any?{ |method| options[:in].respond_to?(method) }
        raise ArgumentError, ERROR_MESSAGE
      end
    end

    def validate
      delimiter = options[:in]
      unless delimiter.send(inclusion_method(delimiter), value)
        add_error :inclusion, value: value
      end
    end

    private
    def inclusion_method(enumerable)
      enumerable.is_a?(Range) ? :cover? : :include?
    end

  end
end


