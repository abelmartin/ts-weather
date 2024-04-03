module HomeHelper
  def map_url
    root = 'https://www.openstreetmap.org/export/embed.html'
    map_coords = @forecast[:lat_lon].reverse.join(',')
    params = {
      # bbox: '-73.96395206451417,40.75717253693376,-73.90730381011964,40.786845400329625'
      bbox: "#{map_coords},#{map_coords}"
    }

    "#{root}?#{URI.encode_www_form(params)}"
  end

  def map_link
    path = @forecast[:lat_lon].join('/')
    "https://www.openstreetmap.org/#map=13/#{path}"
  end

  def temp(temperature)
    "#{temperature.round}°F"
  end

  def humanized_cache_ttl
    # We'll get the ttl as a float to make decisions on how to display it
    minutes = @forecast[:cache_ttl] / 60
    seconds_text = "#{@forecast[:cache_ttl] % 60} #{'second'.pluralize(@forecast[:cache_ttl])}"

    # With integer division, we'll always get the number of minutes.
    # If the number of minutes is 0, we'll just display the seconds
    # When the ttl truly hits 0, we'd refresh the cache and set a new ttl.
    if minutes == 0
      seconds_text
    else
      "#{minutes} #{'minute'.pluralize(minutes)}, #{seconds_text}"
    end
  end
end
