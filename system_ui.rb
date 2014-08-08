require 'pg'
require './lib/line'
require './lib/train'

DB = PG.connect({:dbname => 'trains'})

def main_menu
  puts "                                             `      "
  puts "                                  _____    ___`__|  "
  puts "----WELCOME TO CHOO CHOO TOWN!   |_@_@_|==|_@___@_} "
  puts "\n\n\n"
  puts "Press 's' to add a station"
  puts "Press 'l' to add a line"
  puts "Press 'a' to access all stops on a line"
  puts "Press 'y' to yield all lines on a stop"
  puts "Press 'e' to exit"
  puts "Press 'r' to repeat options"
  input = gets.chomp

  case (input)
  when 's'
    add_station
  when 'l'
    add_line
  when 'a'
    view_stops
  when 'y'
    yield_lines
  when 'e'
    exit
  when 'r'
    puts "really?"
  else
    puts "Not a valid input"
  end
main_menu
end

def add_station
  puts "Enter station name"
  new_station = Station.new({:name => gets.chomp}).save
  puts "Got it!"
  puts "What line stops here?"
  new_station.update_train_lines(gets.chomp)
  puts "Sweet!"
end

def add_line
  puts "Enter a line name"
  new_line = Line.new({:name => gets.chomp})
  new_line.save
  puts "Awesome thanks!"
end

def view_stops
  puts "Which line are you looking for?"
  stops = Station.station_list(gets.chomp)
  stops.each do |stop|
    puts stop.name
  end
end


main_menu

