#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe DataValidator::FormatValidator do
  context 'validation true' do
    context 'with' do
      subject do
        DataValidator::Validator.new(
          {name: "abc"},
          {name: {format: {with: /\A[a-zA-Z]+\z/}}}
        ).valid?
      end
      it { should be_true }
    end
    context 'without' do
      subject do
        DataValidator::Validator.new(
          {name: "123"},
          {name: {format: {without: /\A[a-zA-Z]+\z/}}}
        ).valid?
      end
      it { should be_true }
    end
  end

  context 'validation false' do
    context 'with' do
      before do
        @obj = DataValidator::Validator.new(
          {name: "123"},
          {name: {format: {with: /\A[a-zA-Z]+\z/}}}
        )
      end
      it { @obj.valid?.should be_false }
      it do
        @obj.valid?
        @obj.errors.should eql({name: ["is invalid"]})
      end
    end
    context 'without' do
      before do
        @obj = DataValidator::Validator.new(
          {name: "abc"},
          {name: {format: {without: /\A[a-zA-Z]+\z/}}}
        )
      end
      it { @obj.valid?.should be_false }
      it do
        @obj.valid?
        @obj.errors.should eql({name: ["is invalid"]})
      end
    end
  end

  context 'invalid optiosn' do
    context 'with and without both' do
      it do
        expect do
          DataValidator::Validator.new(
            {name: "123"},
            {name: {format: {with: /\d+/, without: /\A[a-zA-Z]+\z/}}}
          ).valid?
        end.to raise_error(ArgumentError)
      end
    end
    context 'a regular expression nor proc' do
      it do
        expect do
          DataValidator::Validator.new(
            {name: "123"},
            {name: {format: {with: "test"}}}
          ).valid?
        end.to raise_error(ArgumentError)
      end
    end
  end
end


