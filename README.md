# Zonebie

[![Build Status](https://secure.travis-ci.org/highgroove/zonebie.png)](http://travis-ci.org/highgroove/zonebie)

Zonebie prevents bugs in code that deals with timezones by randomly assigning a
zone on every run.

## Requirements

* MRI (1.8.7, 1.9.2, 1.9.3)
* JRuby (1.6)
* Rubinius (1.2, 2.0)

***

And **either** of these gems which adds timezone support to Ruby:

* `activesupport` >= 2.3 (Rails 2.3, 3.0, 3.1, 3.2)
* `tzinfo` >= 0.3

## Installation

If using Bundler (recommended), add to Gemfile:

````ruby
gem 'zonebie'
````

## Usage with Rails & ActiveSupport

ActiveSupport allows setting a global timezone that will be used for many date
and time calculations throughout the application.

Zonebie can set this to a random timezone at the beginning of test runs.
Specifically for ActiveSupport, it sets `Time.zone`.

### Test::Unit & Minitest

Add to `test/test_helper.rb`:

```ruby
Zonebie.set_random_timezone
```

### RSpec

Add to `spec/spec_helper.rb`:

```ruby
Zonebie.set_random_timezone
```

### Cucumber

Add a file `features/support/zonebie.rb` with the following contents:

```ruby
Zonebie.set_random_timezone
```

## Usage with TZInfo

Zonebie can use the `tzinfo` gem, allowing it to work outside of ActiveSupport
(Rails).

However, `Zonebie.set_random_timezone` does not work outside of ActiveSupport
because there is not a concept of a global timezone setting. If you simply need
a random timezone for some other part of your tests, Zonebie can help.

```ruby
zone = TZInfo::Timezone.get(Zonebie.random_timezone)
puts zone.now

# Also works in Rails/ActiveSupport
zone = ActiveSupport::TimeZone[Zonebie.random_timezone]
puts zone.now
```

## Reproducing Bugs

When `Zonebie.set_random_timezone` is called, Zonebie assigns a timezone and
prints a message to STDOUT:

```
[Zonebie] Setting timezone to "Eastern Time (US & Canada)"
```

If you would rather that Zonebie not print out this information during your tests,
put Zonebie in quiet mode before calling `set_random_timezone`:

```ruby
Zonebie.quiet = true
```

To rerun tests with a specific timezone (e.g., to reproduce a bug that only
seems present in one zone), set the `TZ` environment variable:

```ruby
# Assuming tests run with simply `rake`
TZ="Eastern Time (US & Canada)" rake
```

## For the Geographically Impaired

Zonebie can generate an ASCII map that shows where on the globe your tests are
running.

Note that this makes a request to Google Maps, so it's likely not a good idea
to run on each test run :)

```
                     .....   ......                                             
                    ..... ...........                       .                   
                .  . ..  ...........       .                  .                 
            .    .. ..  ...........                    .       ..               
            ..   .. .      ........                 .      .......              
   .....     .... .   ...   .......          ..      . . ...................    
............ ........  ...  ...    ..      ..... ...............................
  ...  ......... .    ..                 ..... ............................  .  
          ........... ... .           ..  .....................  ......         
            .............               ........ .. ...................         
            ...........               ..   .  ..... ............... .           
               ...   .               .............. ................            
                 ...                ............. ..     ..  ...   .            
                      .....           .. ..........               . .           
                      ..........           ......                       .       
                        .......            .....  .                 .....       
                        .....               ...                   .........     
                       ....                                             ..      
                       ..                                                       
                        .                                                       
                                                                                
                         .                                                      
                        ..                    .......... ...................    
           .     .... ....          ..........................................  
       ............... .         ............................................   
    ..................       .  .............................................   
     .....................     .............................................    
     .........................................................................  
     ...........................................................................
```

Enable the map by setting the `:ascii_map` option to `true`. Again, because it
makes an HTTP request, you likely only want to enable it in certain
circumstances (e.g., on a CI server or when you explicitly request it):

```ruby
Zonebie.set_random_timezone(:ascii_map => ENV['CI'] || ENV['MAP'])
```

And run with:

```ruby
MAP=1 rake
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
