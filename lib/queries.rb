
module Queries
  def first
    result = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
      LIMIT
        1
    SQL
    parse_all(result)[0]
  end

  def last
    self.all.last
  end

  def retrieve_columns
    table = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
      LIMIT
        1
    SQL
    @columns = table.first.map(&:to_sym)
  end

  def all
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    parse_all(results)
  end
end
