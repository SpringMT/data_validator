# DataValidator [![Build Status](https://travis-ci.org/SpringMT/data_validator.png)](https://travis-ci.org/SpringMT/data_validator)

DataValidator is validation everywhere.  
For Example, Controller or else.  

## Sample

~~~
params = {foo: 'foo', bar: 'bar'}validator = DataValidator::Validator.new(  params,  {foo: {length: {is: 4}}},  {bar: {presence: true, format: {with: /\A[a-zA-Z]+\z/}}})unless validator.valid?  @errors = validator.errorsend@errors=> {  foo: ["is the wrong length (should be 4 characters)"],  bar: ["can't be blank", "is invalid"]}
~~~

## Validation logic
DataValidator has almost AR validation logics by default.

* acceptance
* confirmation
* format
* inclusion
* length
* numericality
* presence

## Error message
DataValidator supports i18n.  
If you use rails, you not worry about locale file.  

## Original Validation
Ex)

~~~
# encoding: UTF-8

module DataValidator
  class TestValidator < BaseValidator
    def validate
      if options && values !~ /[^@]+$/
        error_add :invalid_test, test: value
      end
    end
  end
end
~~~

BaseValidator set accessors below.  

* name    : validating parmater name
* value   : validating paramter value
* options : validation rules

Please see test case.  

An error message subject uses "datavalidator.attribute.#{name}" in i18n locale file or name.


## Installation

Add this line to your application's Gemfile:

    gem 'data_validator'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install data_validator

## Usage

    require 'data_validator'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2012- HARUAYMA Makoto (SpringMT)

## License
MIT (see MIT-LICENSE)

