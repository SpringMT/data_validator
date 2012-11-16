# encoding: UTF-8

require 'active_support/core_ext/object/blank'

module FormValidator
  class PresenceValidator < BaseValidator
    def valid?
      raise RuntimeError unless options

      if options && (value.nil? || value.blank?)
        error_add :blank
        return false
      end
      true
    end
  end
end

