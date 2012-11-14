# encoding: UTF-8

require 'rubygems'
require 'bundler'
require 'ap'
#Bundler.setup(:default, :test)
#Bundler.require(:default, :test)

require 'rspec'

$TESTING=true
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'form_validator'

I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'locale', '*.{rb,yml}')]


