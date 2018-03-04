class Ride
  attr_accessor :start_location, :finish_location, :start_time, :finish_time

  def initialize params
    @start_location = params[:start_location]
    @finish_location = params[:finish_location]
    @start_time = params[:start_time]
    @finish_time = params[:finish_time]
  end
end
