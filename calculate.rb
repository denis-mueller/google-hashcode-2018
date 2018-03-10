#====================
# Constants
#====================

FILES = [
  'a_example.in',
  'b_should_be_easy.in',
  'c_no_hurry.in',
  'd_metropolis.in',
  'e_high_bonus.in'
].freeze

#====================
# Methods
#====================

def setup_cars(input)
  Array.new(input[0][2]).each_with_index.map do |_item, index|
    {
      id: index,
      rides: [],
      position: { x: 0, y: 0 },
      current_time: 0
    }
  end
end

def setup_rides(input)
  input.drop(1).each_with_index.map do |ride, index|
    {
      id: index,
      position_start: { x: ride[0], y: ride[1] },
      position_finish: { x: ride[2], y: ride[3] },
      time_start: ride[4],
      time_finish: ride[5]
    }
  end
end

def write_file(file, cars)
  file = File.open("#{file[0..-4]}.out.txt", 'w')
  cars.each { |car| file.puts "#{car[:rides].count} #{car[:rides].join(' ')}" }
end

def file_to_array(file)
  IO.readlines(file).map { |line| line.split(' ').map(&:to_i) }
end

def cars_with_rides(cars, rides)
  cars.map do |car|
    car.merge(rides: (suitable_rides(car, cars, rides).map { |ride| ride[:id] }))
  end
end

def suitable_rides(car, cars, rides)
  rides.sort_by { |ride| ride[:time_start] }.each_with_index.select { |_ride, index| index % cars.count == car[:id] }
       .map { |ride_with_index| ride_with_index[0] }
end

#====================
# Main program
#====================

FILES.each do |file|
  input = file_to_array(file)
  cars = setup_cars input
  rides = setup_rides input

  write_file file, cars_with_rides(cars, rides)
end
