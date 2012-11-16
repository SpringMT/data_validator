#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe FormValidator::InclusionValidator do
  context 'valid' do
    context 'is' do
      subject do
        FormValidator::Validator.new(
          {name: 'name'},
          {name: {inclusion: {in: ['name', 'hoge']}}}
        ).valid?
      end
      it { should be_true }
    end
  end

end


