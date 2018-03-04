require_relative 'setup'
require_relative 'models/ride'
require_relative 'models/car'

# Main class
class Main
  def run
    data_sets = Setup.new.data_sets
    pp data_sets
  end
end

Main.new.run
