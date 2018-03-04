require 'pp'
# row column cars rides bonus time
# start_r start_c end_r end_c starttime latest
files = [
  # "a_example.in",
  'b_should_be_easy.in',
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

  sorted_data_body = data[:body].sort_by { |a| a[4] }
  pp sorted_data_body
  (1..data[:header][2]).each do |car_number|
    rides_of_this_car = []

    rides_per_car = if car_number == data[:header][2]
                      (data[:header][3] / data[:header][2]) - 1
                    else
                      (data[:header][3] / data[:header][2])

                    end

    rides_per_car.times do |ride_index|
      rides_of_this_car << sorted_data_body[car_number + (data[:header][2] * ride_index)][6]
    end

    line = rides_per_car.to_s

    rides_of_this_car.each do |ride|
      line << " #{ride}"
    end
    outputfile.puts line
  end
end
