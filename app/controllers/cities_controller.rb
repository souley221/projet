require 'forecast_io'
class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]

  # GET /cities
  # GET /cities.json
  def index
    @cities = City.all
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
  end
  
  def show
    forecast = ForecastIO.forecast(@city.lattitude, @city.longitude)
    weatherOk = false
    temperatureOk = false
    i = 0
    if forecast
      i=i+1
      todayForecast = forecast.currently
      if todayForecast
        i=i+1
        if todayForecast.summary
          i=i+1
          @weatherSummary = todayForecast.summary
          weatherOk = true
        end
        if todayForecast.temperature
          i=i+1
          @weather_io = toCelsus(todayForecast.temperature)
          @weatherTemperature = weather_io.round(2);
          temperatureOk = true
        end
      end
    end
    if !weatherOk
      @weatherSummary = 0
    end
    if !temperatureOk
      @weatherTemperature = 0
    end
end
  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to @city, notice: 'City was successfully created.' }
        format.json { render :show, status: :created, location: @city }
      else
        format.html { render :new }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to @city, notice: 'City was successfully updated.' }
        format.json { render :show, status: :ok, location: @city }
      else
        format.html { render :edit }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to cities_url, notice: 'City was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name, :lattitude, :longitude)
    end
def toCelsus(fahrenheitTemperature)
      if fahrenheitTemperature
        return (fahrenheitTemperature - 32.0) * 5.0 / 9.0
      else
        return nil
      end
    end
end