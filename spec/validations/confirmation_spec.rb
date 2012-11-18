#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe DataValidator::AcceptanceValidator do
  context 'validation true' do
    subject do
      params = {password: "password", password_confirmation: "password"}
      DataValidator::Validator.new(
        params,
        {
          password: {confirmation: {criterion: params[:password_confirmation]}},
          password_confirmation: {presence: true}
        }
      ).valid?
    end
    it { should be_true }
  end
  context 'validation false' do
    before do
      params = {password: "password", password_confirmation: "hoge"}
      @obj = DataValidator::Validator.new(
        params,
        {
          password: {confirmation: {criterion: params[:password_confirmation]}},
          password_confirmation: {presence: true}
        }
      )
    end
    it { @obj.valid?.should be_false }
    it do
      @obj.valid?
      @obj.errors.should eql({password: ["doesn't match confirmation"]})
    end
  end
end


