class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show edit update destroy ]

  # GET /locations or /locations.json
  def index
    if params[:place].present?
    @locations = Location.near(params[:place],params[:distance] , order: :distance )
    else
    @locations = Location.all
    end
  end

  # GET /locations/1 or /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)
    @location.geocode

    puts "#{@location.longitude} , #{@location.latitude}"

      if @location.latitude && @location.longitude && @location.save
        redirect_to location_url(@location), notice: "Location was successfully created."
      else
        render :new, notice: @location.errors 
      end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to location_url(@location), notice: "Location was successfully updated." }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy!

    respond_to do |format|
      format.html { redirect_to locations_url, notice: "Location was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # def search
  #   if params[:place].present?
  #     location = Geocoder.search(params[:place])&.try(:first)&.try(:data)
  #     if location
  #       @name = location["name"]
  #       @latitude = location["lat"]
  #       @longitude = location["lon"]
  #     else
  #       flash[:alert] = "Location not found."
  #     end
  #     redirect_to locations_new_search_path
  #   end
  # end

  # def new_search
  #   @location = Location.new
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:name, :address)
    end

end
