class Line

  attr_accessor :name, :id

  def initialize(line_info)
    @name = line_info[:name]
    @id = line_info[:id]
  end

  def save
    results = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;").first
    @id = results['id'].to_i
  end

  def self.all
    lines = []
    results = DB.exec("SELECT * FROM lines;")
    results.each do |result|
      lines << Line.new({:id => result['id'], :name => result['name']})
    end
    lines
  end

  def ==(another_line)
    self.name == another_line.name
  end

  def self.line_list(station_input)
    lines = []
    results = DB.exec("SELECT lines.* FROM
      stations JOIN train_lines ON (stations.name = train_lines.station_name)
            JOIN lines ON (train_lines.line_name = lines.name)
      WHERE stations.name = '#{station_input}';")
    results.each do |result|
      lines << Line.new({:id => result['id'], :name => result['name']})
    end
    lines
  end
end
