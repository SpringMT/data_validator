#!/usr/bin/env ruby
# encoding: UTF-8

require File.dirname(__FILE__) + '/spec_helper'

module DataValidator
  class DummyValidator
    attr_accessor :name, :value, :options, :errors
    def initialize(name, value, options, errors)
      @name = name; @value = value; @options = options; @errors = errors;
    end
    def check_validity!
    end
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
    context 'allow_nil with nil params' do
      subject { DataValidator::Validator.new({name: nil}, {name: {dummy: true, allow_nil: true}}).valid? }
      it { should be_true }
    end
    context 'allow_nil with blank params' do
      subject { DataValidator::Validator.new({name: ""}, {name: {dummy: false, allow_nil: true}}).valid? }
      it {should be_false}
    end
    context 'allow_blank with blank params' do
      subject { DataValidator::Validator.new({name: ""}, {name: {dummy: true, allow_blank: true}}).valid? }
      it { should be_true }
    end
    context 'undefied validatior' do
      it { expect { DataValidator::Validator.new({name: 'dummy'}, {name: {test: true}}).valid? }.to raise_error(NameError) }
    end
    context 'validation true' do
      subject { DataValidator::Validator.new({name: 'dummy'}, {name: {dummy: true}}).valid? }
      it { should be_true }
    end
    context 'validation false' do
      let(:obj) { DataValidator::Validator.new({name: 'dummy'}, {name: {dummy: false}}) }
      it { obj.valid?.should be_false }
      it do
        obj.valid?
        obj.errors[:name].should be_eql 'dummy error'
      end
    end

  end
end


