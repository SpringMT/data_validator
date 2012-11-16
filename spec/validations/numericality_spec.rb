#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe FormValidator::LengthValidator do
  context 'valid' do
    context 'is' do
      subject do
        FormValidator::Validator.new(
          {name: "123"},
          {name: {numericality: true}}
        ).valid?
      end
      it { should be_true }
    end
    context 'greater_than' do
      subject do
        FormValidator::Validator.new(
          {name: "123"},
          {name: {numericality: {greater_than: 100}}}
        ).valid?
      end
      it { should be_true }
    end
  end

end


