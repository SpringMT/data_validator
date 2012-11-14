#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe FormValidator::PresenceValidation do
  context 'presence' do
    context 'valid' do
      subject do
        FormValidator::Validator.new(
          {name: 'name'},
          {name: {presence: true}}
        ).valid?
      end
      it { should be_true }
    end
    context 'invalid' do
      before { @obj = FormValidator::Validator.new({name: ''}, {name: {presence: true}}) }
      it { @obj.valid?.should be_false }
      it do
        @obj.valid?
        @obj.errors.should be_eql name: "can't be blank"
      end
    end
  end
end
