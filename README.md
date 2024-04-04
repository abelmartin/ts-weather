# README
My solution for a programming challenge.  [Try it out here](https://ts-weather-b615badbc0fe.herokuapp.com/)

## The prompt
* Accept an address as input
* Retrieve forecast data for the given address. This should include, at minimum, the current temperature (Bonus points - Retrieve high/low and/or extended forecast)
* Display the requested forecast details to the user
* Cache the forecast details for 30 minutes for all subsequent requests by zip codes.
* Display indicator if result is pulled from cache.

## Usage
As the prompt requires, once the service is running you can enter:
* an address
* city & state
* city & country

... and the app will return:
* current temperature
* high/low
* extended forcast

It will also cache responses for 30 mins per zip code.

## Additional gems added beyond standard Rails gems

### Weather forecast gem
* [openweathermap](https://rubygems.org/gems/openweathermap) - Provides a clean way to get forecast data from [OpenWeatherMap](https://openweathermap.org/)'s API.  OpenWeatherMap's call limits on the [free tier are very flexible](https://openweathermap.org/price#:~:text=60%20calls/minute%0A1%2C000%2C000%20calls/month)

### Address validation
* [geocoder](https://www.rubygeocoder.com/) - I'll ensure the address passed in is valid before I make the call to OpenWeatherMap.  I'll be using the lat/long in the response in my OpenWeatherMap call.

### Testing 
* [rspec-rails](https://rubygems.org/gems/rspec-rails) - RSpec has become a standard in the Rails community and is my favoritee unit testing library
* [webmock](https://rubygems.org/gems/webmock) - Webmock ensures that no network requests are allowed during test runs.
* [timecop](https://rubygems.org/gems/timecop) - "A gem providing "time travel" and "time freezing" capabilities, making it dead simple to test time-dependent code." ~Timecop repository.

### Debugging
* [pry-byebug](https://rubygems.org/gems/pry-byebug) - Helpful for setting breakpoints while building the solution

### Orchstration
* [foreman](https://rubygems.org/gems/foreman) - Useful to manage both my Puma web server and my webpacker server.
** I have `Procfile` for Heroku and `Procfile.dev` for my local environment.
* [dotenv-rails](https://rubygems.org/gems/dotenv-rails) - Useful to load environment variables from my .env file.

### Caching
* [redis](https://rubygems.org/gems/redis) - Using Redis to store my cached weather calls.  [Redis' TTL](https://redis.io/commands/ttl/) method allows me to easily get the expiration time of the cached data.

## Get started

1. Install Ruby 3.x

- I'm using the latest version of Ruby, but any version of Ruby 3 should work.

2. Install Redis

- Required for caching

3. Install Bundler
```
gem install bundler
```
4. Run `bundle install`
- This will install all required gems for the app.

5. Copy the [.env-sample](https://github.com/abelmartin/ts-weather/blob/main/.env-sample) and save it as `.env`.  You'll need to get an API key for OpenWeatherMap for this solution to work.  The `Raygun` API key is a nice to have for error reporting that isn't a necessity.

6. Run `foreman start -f Procfile.dev`

## Running the test suite

After running installing Ruby & Bundler as outlined in the `Get started` section above, run `bundle exec rspec` to run the suite of tests I wrote for this project.

If you'd like you can also run `bundle exec rubocop` to see how I've stayed in Ruby best practices.  Adjustments I've made to Rubocop can be found [here](https://github.com/abelmartin/ts-weather/blob/main/.rubocop.yml)