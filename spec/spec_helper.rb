require 'pg'
require 'train'
require 'line'
require 'rspec'

DB = PG.connect({:dbname => 'station_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM lines *;")
    DB.exec("DELETE FROM stations *;")
    DB.exec("DELETE FROM train_lines *;")
  end
end
