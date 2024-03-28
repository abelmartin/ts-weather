# README
My solution for a programming challenge

## The prompt
* Accept an address as input
* Retrieve forecast data for the given address. This should include, at minimum, the current temperature (Bonus points - Retrieve high/low and/or extended forecast)
* Display the requested forecast details to the user
* Cache the forecast details for 30 minutes for all subsequent requests by zip codes.
* Display indicator if result is pulled from cache.

## API
### Weather
* Weather will be pulled from [NOAA](https://www.weather.gov/documentation/services-web-api).  This works well as NOAA provides this services for free.  There's a rate limit but [as the API's page states](https://www.weather.gov/documentation/services-web-api#:~:text=The%20rate%20limit,are%20not%20likely.):
```
The rate limit is not public information, but allows a generous amount for typical use. If the rate limit is execeed a request will return with an error, and may be retried after the limit clears (typically within 5 seconds). Proxies are more likely to reach the limit, whereas requests directly from clients are not likely.
```

## Additional gems added beyond standard Rails gems
### Address validation
* [geocoder](https://rubygems.org/gems/pry-byebug) - I'll ensure the address passed in is valid before I make the call to NOAA

### Testing 
* [rspec-rails](https://rubygems.org/gems/rspec-rails) - RSpec has become a standard in the Rails community and is my favoritee unit testing library

### Debugging
* [pry-byebug](https://rubygems.org/gems/pry-byebug) - Helpful for setting breakpoints while building the solution

### Orchstration
* [foreman](https://rubygems.org/gems/foreman) - Useful to manage both my Puma web server and my webpacker server.
** I have `Procfile` for Heroku and `Procfile.dev` for my local environment.
* [dotenv-rails](https://rubygems.org/gems/dotenv-rails) - Useful to load environment variables from my .env file.

## Get started

1. Install Ruby 3.x

- I'm using the latest version of Ruby, but any version of Ruby 3 should work.

2. Install Bundler
```
gem install bundler
```
3. Run `bundle install`
- This will install all required gems for the app.
4. Run `foreman start -f Procfile.dev`

## Running the test suite

After running installing Ruby & Bundler as outlined in the `Get started` section above, run `bundle exec rspec` to run the suite of tests I wrote for this project.