
module Searchable
  def where(params)
    set_string = params.map do |key, val|
      "#{key} = ?"
     end.join(" AND ")
     matches = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{set_string}
      SQL
    parse_all(matches)
  end

  def find(id)
    item = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL
    item.empty? ? nil : self.new(item.first)
  end
end
