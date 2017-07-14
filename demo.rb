require_relative 'lib/sql_object'
require_relative 'lib/db_connection'

class Human < SQLObject
  self.table_name = "humans"

  has_many :cats,
  primary_key: :id,
  foreign_key: :owner_id,
  class_name: 'Cat'

  belongs_to :house
end

class Cat < SQLObject
  belongs_to :owner,
  primary_key: :id,
  foreign_key: :owner_id,
  class_name: 'Human'

  #cats do not store references to homes, but thier owner does
  has_one_through :home, :owner, :house
end

class House < SQLObject
  has_many :humans
end
