# encoding: UTF-8

module FormValidator
  class LengthValidation
    def valid?(name, value, threshold, errors)
      
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


