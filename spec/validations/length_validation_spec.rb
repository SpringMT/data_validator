#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe DataValidator::LengthValidator do
  context 'validation true' do
    context 'is' do
      subject do
        DataValidator::Validator.new(
          {name: 'name'},
          {name: {length: {is: 4}}}
        ).valid?
      end
      it { should be_true }
    end
    context 'is with token' do
      subject do
        DataValidator::Validator.new(
          {name: 'i am test name'},
          {name: {length: {is: 4, tokenizer: lambda { |str| str.scan(/\w+/) }}}}
        ).valid?
      end
      it { should be_true }
    end
    context 'maximum and minimum' do
      subject do
        DataValidator::Validator.new(
          {name: 'name'},
          {name: {length: {maximum: 100, minimum: 2}}}
        ).valid?
      end
      it { should be_true }
    end
    context 'in' do
      subject do
        DataValidator::Validator.new(
          {name: 'name'},
          {name: {length: {in: 3..7}}}
        ).valid?
      end
      it { should be_true }
    end
  end

  context 'validation false' do
    context 'is' do
      before do
        @obj = DataValidator::Validator.new(
          {name: 'name'},
          {name: {length: {is: 5}}}
        )
      end
      it { @obj.valid?.should be_false }
      it do
        @obj.valid?
        @obj.errors.should eql({name: ["name is the wrong length (should be 5 characters)"]})
      end
    end
    context 'maximum' do
      before do
        @obj = DataValidator::Validator.new(
          {name: 'name'},
          {name: {length: {maximum: 2}}}
        )
      end
      it { @obj.valid?.should be_false }
      it do
        @obj.valid?
        @obj.errors.should eql({name: ["name is too long (maximum is 2 characters)"]})
      end
    end
    context 'minimum' do
      before do
        @obj = DataValidator::Validator.new(
          {name: 'name'},
          {name: {length: {minimum: 5}}}
        )
      end
      it { @obj.valid?.should be_false }
      it do
        @obj.valid?
        @obj.errors.should eql({name: ["name is too short (minimum is 5 characters)"]})
      end
    end
  end

  context 'invalid options' do
    context 'not Range with in:' do
      it do
        expect do
          DataValidator::Validator.new(
            {name: 'name'},
            {name: {length: {in: 123}}}
          ).valid?
        end.to raise_error(ArgumentError)
      end
    end
    context 'unexist options' do
      it do
        expect do
          DataValidator::Validator.new(
            {name: 'name'},
            {name: {length: {test: 123}}}
          ).valid?
        end.to raise_error(ArgumentError)
      end
    end
    context 'negative Integer' do
      it do
        expect do
          DataValidator::Validator.new(
            {name: 'name'},
            {name: {length: {minimum: -1}}}
          ).valid?
        end.to raise_error(ArgumentError)
      end
    end
  end
end


