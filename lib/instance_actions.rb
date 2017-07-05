require_relative 'db_connection'

module InstanceActions
  def insert
    col_names = self.class.columns.join(", ")
    question_marks = ['?'] * self.class.columns.length
    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks.join(",")})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    question_marks = ['?'] * self.class.columns.length
    set_string = self.class.columns.map {|val| "#{val} = ?"}.join(", ")
    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_string}
      WHERE
        id = ?
    SQL
  end

  def save
    id ? update : insert
  end
end
