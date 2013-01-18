#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe DataValidator::BaseValidator do
  describe :initialize do
    context 'options is blank' do
      it { expect{ DataValidator::BaseValidator.new(:name, 'value', '', {}) }.to raise_error(ArgumentError) }
    end
    context 'options is true' do
      subject { DataValidator::BaseValidator.new(:name, 'value', true, {}) }
      it { subject.options.should be_eql({}) }
    end
    context 'options is hash' do
      subject { DataValidator::BaseValidator.new(:name, 'value', {test: 'test'}, {})  }
      it { subject.options.should be_eql({test: 'test'}) }
    end
  end

  describe :validate do
    context 'validate method is override' do
      it { expect{ DataValidator::BaseValidator.new(:name, 'value', true, {}).validate }.to raise_error(ArgumentError) }
    end
  end

  describe :add_error do
    before { @obj = DataValidator::BaseValidator.new(:name, 'value', true, {}) }
    context 'add an error first' do
      it do
        @obj.add_error(:blank)
        @obj.errors.should eql({name: ["name can't be blank"]})
      end
    end
    context 'add an errors secondly' do
      it do
        @obj.add_error(:blank)
        @obj.add_error(:invalid)
        @obj.errors.should eql({name: ["name can't be blank", "name is invalid"]})
      end
    end
    context 'non default locale error message' do
      it do
        I18n.locale = :jp
        @obj.add_error(:blank)
        @obj.errors.should eql({name: ["名前 は必須項目です"]})
      end
      after { I18n.locale = :en }
    end
  end
end


