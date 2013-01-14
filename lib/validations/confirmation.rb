# encoding: UTF-8

module DataValidator
  class ConfirmationValidator < BaseValidator
    def validate
      if value != options[:criterion]
        add_error :confirmation
      end
    end
  end
end


