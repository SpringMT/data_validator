#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe DataValidator::AcceptanceValidator do
  context 'validation true' do
    subject do
      DataValidator::Validator.new(
        {terms_of_service: '1'},
        {terms_of_service: {acceptance: true}}
      ).valid?
    end
    it { should be_true }
  end
  context 'validation true with different accept' do
    subject do
      DataValidator::Validator.new(
        {terms_of_service: 'yes'},
        {terms_of_service: {acceptance: {accept: 'yes'}}}
      ).valid?
    end
    it { should be_true }
  end
  context 'validation false' do
    before do
      @obj = DataValidator::Validator.new(
        {terms_of_service: '0'},
        {terms_of_service: {acceptance: true}}
      )
    end
    it { @obj.valid?.should be_false }
    it do
      @obj.valid?
      @obj.errors.should eql({terms_of_service: ["terms_of_service must be accepted"]})
    end
  end
end


