class City < ActiveRecord::Base
  before_validation :geocode
  
  public
  def meteo
    ForecastIO.forecast(self.lattitude, self.longitude).currently.summary
  end
  private  
  def geocode
    places = Nominatim.search(self.name).limit(1)
    place=places.first
    if place
      self.lattitude = place.lat
      self.longitude = place.lon
    end
  end

end
