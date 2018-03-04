require 'pp'

def calculate_distance(x_car, y_car, x_start, y_start)
  (x_car - x_start).abs + (y_car - y_start).abs
end

def calculate_score(x_car, y_car, x_start, y_start, time_now, time_start)
  (time_now - (time_start - calculate_distance(x_car, y_car, x_start, y_start))).abs
end
# row column cars rides bonus time
# start_r start_c end_r end_c starttime latest
files = [
  'a_example.in',
  # 'b_should_be_easy.in',
  # "c_no_hurry.in",
  # "d_metropolis.in",
  # "e_high_bonus.in",
]

files.each do |file|
  input = IO.readlines(file)

  data = { header: nil, body: [] }
  data[:header] = input.shift.chomp.split(' ').map(&:to_i)

  ride_number = 0
  input.each do |line|
    data[:body] << line.chomp.split(' ').map(&:to_i).push(ride_number)
    ride_number += 1
  end

  outputfile = File.open("#{file[0..-4]}.txt", 'w')
  cars_data = []

  output_rides = []

  until data[:body].empty?
    pp 'hey'
    pp data[:body].empty?
    (1..data[:header][2]).each do |car_number|
      cars_data[car_number] = { x_pos: 0, y_pos: 0, time_now: 0, rides: [] }

      car_data = cars_data[car_number]
      rides = []

      data[:body].sort! do |a, b|
        calculate_score(car_data[:x_pos], car_data[:y_pos], a[0], a[1], car_data[:time_now], a[4]) <=> calculate_score(car_data[:x_pos], car_data[:y_pos], b[0], b[1], car_data[:time_now], b[4])
      end

      pp car_data
      pp data[:body].empty?
      car_data[:x_pos] = data[:body].first[2]
      car_data[:y_pos] = data[:body].first[3]

      a = car_data[:time_now] + calculate_distance(car_data[:x_pos], car_data[:y_pos], data[:body].first[0], data[:body].first[1])
      b = data[:body].first[4]
      max = a > b ? a : b
      car_data[:time_now] = max + calculate_distance(data[:body].first[0], data[:body].first[1], data[:body].first[2], data[:body].first[3])

      output_rides[car_number] = [] if output_rides[car_number].nil?
      output_rides[car_number] << data[:body].shift[6]
    end
    cars_data.shift
    cars_data.sort! do |a, b|
      a[:time_now] <=> b[:time_now]
    end

  end

  outputfile = File.open("#{file[0..-4]}.txt", 'w')
  output_rides.shift
  output_rides.each do |rides|
    line = rides.length.to_s
    rides.each do |ride|
      line << " #{ride}"
    end

    outputfile.puts line
  end
end
