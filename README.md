# Zonebie

TODO: Travis-CI build image

Zonebie prevents bugs in code that deals with timezones by randomly assigning a
zone on every run.

## Requirements

Tests must run green against:

* Ruby 1.8.7, 1.9.2, 1.9.3
* JRuby 1.6 (1.8 and 1.9 mode)
* Rubinius 1.2 and 2.0 (1.8 and 1.9 mode)

A gem that adds timezone support; currently supported is:

* `activesupport` >= 2.3 (compatible with Rails 2.3, 3.0, 3.1, 3.2)

OR

* **Unimplemented** `tzinfo`

## Installation

If using Bundler (recommended), add to Gemfile:

   gem 'zonebie'

### Test::Unit & Minitest

**Unimplemented**

Add to `test/test_helper.rb`:

    Zonebie.assign_random_timezone

### RSpec

**Unimplemented**

Add to `spec/spec_helper.rb` after `require "rspec"` or `require "rspec/rails"`:

    require "zonebie/rspec"

### Cucumber

**Unimplemented**

Add to `features/support/env.rb` after `require "cucumber"` or `require "cucumber/rails"`:

    require "zonebie/cucumber"

## Usage

When `Zonebie.assign_random_timezone` is called (if using RSpec or Cucumber,
this call is automatically setup for you), Zonebie assigns a timezone and
prints a message to STDOUT:

    [Zonebie] Setting timezone to "Eastern Time (US & Pacific)"

To rerun tests with a specific timezone (e.g., to reproduce a bug that only
seems present in one zone), set the `TZ` environment variable:

    # Assuming tests run with simply `rake`
    TZ="Eastern Time (US & Pacific)" rake

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
