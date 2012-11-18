# encoding: UTF-8

module DataValidator
  class LengthValidator < BaseValidator
    MESSAGES  = { :is => :wrong_length, :minimum => :too_short, :maximum => :too_long }.freeze
    CHECKS    = { :is => :==, :minimum => :>=, :maximum => :<= }.freeze

    def check_validity!
      if range = (options.delete(:in) || options.delete(:within))
        raise ArgumentError, ":in and :within must be a Range" unless range.is_a?(Range)
        options[:minimum], options[:maximum] = range.begin, range.end
        options[:maximum] -= 1 if range.exclude_end?
      end

      keys = CHECKS.keys & options.keys
      if keys.empty?
        raise ArgumentError, 'Range unspecified. Specify the :in, :within, :maximum, :minimum, or :is option.'
      end

      keys.each do |key|
        option_value = options[key]
        unless option_value.is_a?(Integer) && option_value >= 0
          raise ArgumentError, ":#{key} must be a nonnegative Integer"
        end
      end
    end

    def validate
      tokenized_value = tokenize value
      value_length = tokenized_value.respond_to?(:length) ? tokenized_value.length : tokenized_value.to_s.length

      CHECKS.each do |key, validity_check|
        next unless check_value = options[key]
        next if value_length.send(validity_check, check_value)
        error_add MESSAGES[key], count: check_value
      end
    end

    private
    def tokenize(value)
      if value.kind_of?(String)
        if options[:tokenizer]
          options[:tokenizer].call(value)
        elsif !value.encoding_aware?
          value.mb_chars
        end
      end || value
    end

  end
end


