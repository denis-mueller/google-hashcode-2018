class Setup
  def data_sets
    input_file_paths.map { |file_path| format_input file_path }
  end

  private 

  def input_file_paths
    Dir.glob('inputs/*.in')
  end

  def format_input(file_path)
    input_lines = IO.readlines(file_path)
    rides = create_rides(input_lines.drop(1))
    cars = [Car.new] * input_lines.first[2] 
    {
      input_file_name: File.basename(file_path),
      cars: cars,
      rides: rides,
      metadata: { 
        height: input_lines.first[0],
        width: input_lines.first[1],
        total_time: input_lines.first[5],
        on_time_bonus: input_lines.first[4],
      }
    }
  end

  def create_rides(rides_data)
    rides_data.map do |ride_data| 
      Ride.new(
        start_location: {
          x: ride_data[0],
          y: ride_data[1]
        },
        finish_location: {
          x: ride_data[2],
          y: ride_data[3]
        },
        start_time: ride_data[4],
        finish_time: ride_data[5]
      )
    end
  end
end
