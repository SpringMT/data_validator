#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe FormValidator::AcceptanceValidator do
  context 'valid' do
    context 'confirmation' do
      subject do
        params = {password: "password", password_confirmation: "password"}
        FormValidator::Validator.new(
          params,
          {
            passwrod: {confirmation: params[:password_confirmation]},
            password_confirmation: {presence: true}
          }
        ).valid?
      end
      it { should be_true }
    end
  end

end


