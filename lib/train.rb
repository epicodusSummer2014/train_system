class Station

  attr_accessor :name, :id

  def initialize(station_info)
    @name = station_info[:name]
    @id = station_info[:id]
  end

  def save
    results = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;").first
    @id = results['id'].to_i
  end

  def self.all
    stations = []
    results = DB.exec("SELECT * FROM stations;")
    results.each do |result|
      stations << Line.new({:id => result['id'], :name => result['name']})
    end
    stations
  end

  def ==(another_station)
    self.name == another_station.name
  end

  def self.station_list(line_input)
    stops = []
    results = DB.exec("SELECT stations.* FROM
      lines JOIN train_lines ON (lines.name = train_lines.line_name)
            JOIN stations ON (train_lines.station_name = stations.name)
      WHERE lines.name = '#{line_input}';")
    results.each do |result|
      stops << Station.new({:id => result['id'], :name => result['name']})
    end
    stops
  end

  def update_train_lines(line_name)
    DB.exec("INSERT INTO train_lines (station_name, line_name) VALUES ('#{self.name}', '#{line_name}');")
  end


end
