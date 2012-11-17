# encoding: UTF-8

module DataValidator
  class ConfirmationValidator < BaseValidator
    def validate
      if value != options[:criterion]
        error_add :confirmation
      end
    end
  end
end


