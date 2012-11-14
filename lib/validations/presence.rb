# encoding: UTF-8

require 'active_support/core_ext/object/blank'

module FormValidator
  class PresenceValidation < BaseValidation
    def valid?
      raise RuntimeError unless options

      if options && (value.nil? || value.blank?)
        errors[key] = I18n.t 'errors.messages.blank'
        false
      end
      true
    end
  end
end

