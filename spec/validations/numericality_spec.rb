#!/usr/bin/env ruby
# encoding: UTF-8

require File.join(File.dirname(__FILE__), '..' ,'spec_helper')

describe DataValidator::LengthValidator do
  shared_examples_for :validtion_true do |params, rule|
    subject do
      DataValidator::Validator.new(
        params,
        rule
      ).valid?
    end
    it { should be_true }
  end
  shared_examples_for :validtion_false do |params, rule, name, message|
    before do
      @obj = DataValidator::Validator.new(
        params,
        rule
      )
    end
    it { @obj.valid?.should be_false }
    it do
      @obj.valid?
      @obj.errors.should eql({name => [message]})
    end
  end

  context 'validtion true' do
    context 'only numeric check' do
      it_behaves_like :validtion_true, {num: "001"}, {num: {numericality: true}}
    end
    context 'greater_than' do
      it_behaves_like :validtion_true, {num: "100.1"}, {num: {numericality: {greater_than: 100}}}
    end
    context 'greater_than_or_equal_to' do
      it_behaves_like :validtion_true, {num: "100"}, {num: {numericality: {greater_than_or_equal_to: 100}}}
    end
    context 'equal_to' do
      it_behaves_like :validtion_true, {num: "100"}, {num: {numericality: {equal_to: 100}}}
    end
    context 'less_than' do
      it_behaves_like :validtion_true, {num: "99.9"}, {num: {numericality: {less_than: 100}}}
    end
    context 'less_than_or_equal_to' do
      it_behaves_like :validtion_true, {num: "100"}, {num: {numericality: {less_than_or_equal_to: 100}}}
    end
    context 'odd' do
      it_behaves_like :validtion_true, {num: "101"}, {num: {numericality: {odd: true}}}
    end
    context 'even' do
      it_behaves_like :validtion_true, {num: "100"}, {num: {numericality: {even: true}}}
    end
    context 'only_integer' do
      it_behaves_like :validtion_true, {num: "-1"}, {num: {numericality: {only_integer: true}}}
    end
  end

  context 'validtion true' do
    context 'only numeric check' do
      it_behaves_like :validtion_false,
        {num: "test"},
        {num: {numericality: true}},
        :num,
        "is not a number"
    end
    context 'greater_than' do
      it_behaves_like :validtion_false,
        {num: "100"},
        {num: {numericality: {greater_than: 100}}},
        :num,
        "must be greater than 100"
    end
    context 'greater_than_or_equal_to' do
      it_behaves_like :validtion_false,
        {num: "99.9"},
        {num: {numericality: {greater_than_or_equal_to: 100}}},
        :num,
        "must be greater than or equal to 100"
    end
    context 'equal_to' do
      it_behaves_like :validtion_false,
        {num: "99"},
        {num: {numericality: {equal_to: 100}}},
        :num,
        "must be equal to 100"
    end
    context 'less_than' do
      it_behaves_like :validtion_false,
        {num: "100"},
        {num: {numericality: {less_than: 100}}},
        :num,
        "must be less than 100"
    end
    context 'less_than_or_equal_to' do
      it_behaves_like :validtion_false,
        {num: "100.1"},
        {num: {numericality: {less_than_or_equal_to: 100}}},
        :num,
        "must be less than or equal to 100"
    end
    context 'odd' do
      it_behaves_like :validtion_false,
        {num: "100"},
        {num: {numericality: {odd: true}}},
        :num,
        "must be odd"
    end
    context 'even' do
      it_behaves_like :validtion_false,
        {num: "101"},
        {num: {numericality: {even: true}}},
        :num,
        "must be even"
    end
    context 'only_integer' do
      it_behaves_like :validtion_false,
        {num: "1.001"},
        {num: {numericality: {only_integer: true}}},
        :num,
        "is not an integer"
    end
  end

  context 'invalid options' do
    context 'option_value is not Numeric' do
      it do
        expect do
          DataValidator::Validator.new(
            {num: "100"},
            {num: {numericality: {greater_than: "aaaa"}}},
          ).valid?
        end.to raise_error(ArgumentError)
      end
    end
  end
end


