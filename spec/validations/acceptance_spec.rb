#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe FormValidator::AcceptanceValidator do
  context 'valid' do
    context 'acceptance' do
      subject do
        FormValidator::Validator.new(
          {terms_of_service: "1"},
          {terms_of_service: {acceptance: true}}
        ).valid?
      end
      it { should be_true }
    end
  end

end


