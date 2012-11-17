#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe DataValidator::LengthValidator do
  context 'valid' do
    context 'is' do
      subject do
        DataValidator::Validator.new(
          {name: "123"},
          {name: {numericality: true}}
        ).valid?
      end
      it { should be_true }
    end
    context 'greater_than' do
      subject do
        DataValidator::Validator.new(
          {name: "123"},
          {name: {numericality: {greater_than: 100}}}
        ).valid?
      end
      it { should be_true }
    end
  end

end


