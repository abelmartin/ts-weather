module HomeHelper
  def map_url
    root = 'https://www.openstreetmap.org/export/embed.html'
    map_coords = @forecast.dig(:lat_lon).reverse.join(',')
    params = {
      # bbox: '-73.96395206451417,40.75717253693376,-73.90730381011964,40.786845400329625'
      bbox: "#{map_coords},#{map_coords}"
    }

    "#{root}?#{URI.encode_www_form(params)}"
  end

  def map_link
    path = @forecast.dig(:lat_lon).join('/')
    "https://www.openstreetmap.org/#map=13/#{path}"
  end
end
