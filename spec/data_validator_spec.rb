#!/usr/bin/env ruby
# encoding: UTF-8

require File.dirname(__FILE__) + '/spec_helper'

module DataValidator
  class DummyValidator < BaseValidator
    def validate
      unless options
        errors[name] = 'dummy error'
      end
      options
    end
  end
end


describe DataValidator::Validator do
  describe :valid? do
    context 'validation true with valid params' do
      subject { DataValidator::Validator.new({name: 'dummy'}, {name: {dummy: true}}).valid? }
      it { should be_true }
    end
    context 'validation false with valid params' do
      # subject { DataValidator::Validator.new({name: 'dummy'}, {name: {dummy: false}}).valid? }
      it { expect{ DataValidator::Validator.new({name: 'dummy'}, {name: {dummy: false}}).valid? }.to raise_error(ArgumentError) }
    end
    context 'allow_blank with blank params' do
      subject { DataValidator::Validator.new({name: false}, {name: {dummy: true, allow_blank: true}}).valid? }
      it { should be_true }
    end
    context 'undefied validations' do
      it { expect { DataValidator::Validator.new({name: 'dummy'}, {name: {test: true}}).valid? }.to raise_error(NameError) }
    end
  end
end

