module IdSequenceHelper
  def next_id
    connection.select_value("select last_value from #{table_name}_#{primary_key}_seq").to_i + 1
  end
end

#TODO: delete this
