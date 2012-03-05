# Zonebie

TODO: Travis-CI build image

Zonebie prevents bugs in code that deals with timezones by randomly assigning a
zone on every run.

## Requirements

Tests must run green against:

* Ruby 1.8.7, 1.9.2, 1.9.3
* JRuby 1.6 (1.8 and 1.9 mode)
* Rubinius 1.2 and 2.0 (1.8 and 1.9 mode)

* `activesupport` >= 2.3 (compatible with Rails 2.3, 3.0, 3.1, 3.2)

OR

* `tzinfo` >= 0.3

## Installation

If using Bundler (recommended), add to Gemfile:

   gem 'zonebie'

## Usage with Rails & ActiveSupport

ActiveSupport allows setting a global timezone that will be used for many date
and time calculations throughout the application.

Zonebie can set this to a random timezone at the beginning of test runs.
Specifically for ActiveSupport, it sets `Time.zone`.

### Test::Unit & Minitest

Add to `test/test_helper.rb`:

    Zonebie.set_random_timezone

### RSpec

Add to `spec/spec_helper.rb`:

    Zonebie.set_random_timezone

### Cucumber

Add a file `features/support/zonebie.rb` with the following contents:

    Zonebie.set_random_timezone

## Usage with TZInfo

Zonebie can use the `tzinfo` gem, allowing it to work outside of ActiveSupport
(Rails).

However, `Zonebie.set_random_timezone` does not work outside of ActiveSupport
because there is not a concept of a global timezone setting. If you simply need
a random timezone for some other part of your tests, Zonebie can help.

    zone = TZInfo::Timezone.get(Zonebie.random_timezone)
    puts zone.now

    # Also works in Rails/ActiveSupport
    zone = ActiveSupport::TimeZone[Zonebie.random_timezone]
    puts zone.now

## Reproducing Bugs

When `Zonebie.set_random_timezone` is called, Zonebie assigns a timezone and
prints a message to STDOUT:

    [Zonebie] Setting timezone to "Eastern Time (US & Canada)"

If you would rather that Zonebie not print out this information during your tests,
put Zonebie in quiet mode before calling `set_random_timezone`:

    Zonebie.quiet = true

To rerun tests with a specific timezone (e.g., to reproduce a bug that only
seems present in one zone), set the `TZ` environment variable:

    # Assuming tests run with simply `rake`
    TZ="Eastern Time (US & Canada)" rake

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
