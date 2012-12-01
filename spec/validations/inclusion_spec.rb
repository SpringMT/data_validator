#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe DataValidator::InclusionValidator do
  context 'validation true' do
    context 'in' do
      subject do
        DataValidator::Validator.new(
          {name: 'name'},
          {name: {inclusion: {in: ['name', 'bar']}}}
        ).valid?
      end
      it { should be_true }
    end
  end

  context 'validation false' do
    before do
      @obj = DataValidator::Validator.new(
        {name: 'name'},
        {name: {inclusion: {in: ['foo', 'bar']}}}
      )
    end
    it {@obj.valid?.should be_false}
    it do
      @obj.valid?
      @obj.errors.should eql({name: ["name is not included in the list"]})
    end
  end

  context 'invalid options' do
    it do
      expect do
        DataValidator::Validator.new(
          {name: "123"},
          {name: {inclusion: {in: 123}}}
        ).valid?
      end.to raise_error(ArgumentError)
    end
  end
end


