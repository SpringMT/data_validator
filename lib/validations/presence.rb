# encoding: UTF-8

module FormValidator
  class PresenceValidator < BaseValidator
    def validate
      raise RuntimeError unless options

      if options && (value.nil? || value.blank?)
        error_add :blank
      end
    end
  end
end

