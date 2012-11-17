#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe DataValidator::FormatValidator do
  context 'valid' do
    context 'with' do
      subject do
        DataValidator::Validator.new(
          {name: "abc"},
          {name: {format: {with: /\A[a-zA-Z]+\z/}}}
        ).valid?
      end
      it { should be_true }
    end
    context 'greater_than' do
      subject do
        DataValidator::Validator.new(
          {name: "123"},
          {name: {format: {without: /\A[a-zA-Z]+\z/}}}
        ).valid?
      end
      it { should be_true }
    end
  end

end


