# encoding: UTF-8

module DataValidator
  class PresenceValidator < BaseValidator
    def validate
      if options && (value.nil? || value.blank?)
        add_error :blank
      end
    end
  end
end

