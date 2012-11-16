#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe FormValidator::LengthValidator do
  context 'valid' do
    context 'is' do
      subject do
        FormValidator::Validator.new(
          {name: 'name'},
          {name: {length: {is: 4}}}
        ).valid?
      end
      it { should be_true }
    end
    context 'is with token' do
      subject do
        FormValidator::Validator.new(
          {name: 'i am test name'},
          {name: {length: {is: 4, :tokenizer => lambda { |str| str.scan(/\w+/) }}}}
        ).valid?
      end
      it { should be_true }
    end
    context 'maximum minimum' do
      subject do
        FormValidator::Validator.new(
          {name: 'name'},
          {name: {length: {maximum: 100, minimum: 2}}}
        ).valid?
      end
      it { should be_true }
    end
    context 'in' do
      subject do
        FormValidator::Validator.new(
          {name: 'name'},
          {name: {length: {in: 3..7}}}
        ).valid?
      end
      it { should be_true }
    end
  end

end


