class Train_lines

  attr_accessor :id, :station_name, :line_name

  def initialize(joint_info)
    @station_name = joint_info[:station_name]
    @line_name = joint_info[:line_name]
    @id = joint_info[:id]
  end



  def save
    results = DB.exec("INSERT INTO train_lines (station_name, line_name) VALUES ('#{@station_name}', '#{@line_name}') RETURNING id;").first
    @id = results['id'].to_i
  end

  def ==(another_stop)
    self.station_name == another_stop.station_name && self.line_name == another_stop.line_name
  end
end
