#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe DataValidator::PresenceValidator do
  context 'validtion true' do
    subject do
      DataValidator::Validator.new(
        {name: 'name'},
        {name: {presence: true}}
      ).valid?
    end
    it { should be_true }
  end
  context 'validation false' do
    before { @obj = DataValidator::Validator.new({name: ''}, {name: {presence: true}}) }
    it { @obj.valid?.should be_false }
    it do
      @obj.valid?
      @obj.errors.should eql({name: ["name can't be blank"]})
    end
  end
end
