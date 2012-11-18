# encoding: UTF-8

module DataValidator
  class FormatValidator < BaseValidator
    def check_validity!
      unless options.include?(:with) ^ options.include?(:without)  # ^ == xor, or "exclusive or"
        raise ArgumentError, "Either :with or :without must be supplied (but not both)"
      end
      check_options_validity(options, :with)
      check_options_validity(options, :without)
    end

    def validate
      if regexp = options[:with]
        error_add :invalid if value.to_s !~ regexp
      elsif regexp = options[:without]
        error_add :invalid if value.to_s =~ regexp
      end
    end

    private
    def check_options_validity(options, name)
      option = options[name]
      if option && !option.is_a?(Regexp) && !option.respond_to?(:call)
        raise ArgumentError, "A regular expression or a proc or lambda must be supplied as :#{name}"
      end
    end

  end
end


