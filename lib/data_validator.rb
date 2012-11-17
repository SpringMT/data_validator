# encoding: UTF-8

require 'data_validator/version'
require 'active_support/core_ext'
require 'validations/base'

module DataValidator
  class Validator
    attr_accessor :errors

    def initialize(params, rules)
      @params = params
      @rules  = rules
      @errors = {}
    end

    def valid?
      @rules.each_pair do |key, rule|
        next if @params[key].blank? && rule[:allow_blank]
        next if @params[key].nil? && rule[:allow_nil]
        # blnak nilの場合のcheck
        rule.each_pair do |validator, options|
          klass = "#{validator.capitalize}Validator"
          #raise RuntimeError unless defined? "FormValidator::#{klass}"
          constant   = Object
          constant   = constant.const_get "DataValidator"
          validation = constant.const_get(klass).new(key, @params[key], options, @errors)
          validation.check_validity!
          validation.validate
        end
      end
      if error?
        return false
      else
        return true
      end
    end

    def error?
      @errors.present?
    end

  end
end

Dir[File.dirname(__FILE__) + "/validations/*.rb"].sort.each do |path|
  filename = File.basename(path)
  require "validations/#{filename}"
end


