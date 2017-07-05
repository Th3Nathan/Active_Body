require 'active_support/inflector'

class AssocOptions
  attr_accessor :foreign_key, :class_name, :primary_key

  def model_class
    @class_name.to_s.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    default_options = {
      primary_key: :id,
      foreign_key: ("#{name}_id").to_sym,
      class_name: name.to_s.capitalize
    }

    default_options.merge(options).each do |option, val|
      self.send("#{option}=", val)
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    default_options = {
      primary_key: :id,
      foreign_key: (self_class_name.to_s.downcase + '_id').to_sym,
      class_name: name.to_s.singularize.capitalize
    }

    default_options.merge(options).each do |option, val|
      self.send("#{option}=", val)
    end
  end
end

module Associatable
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    assoc_options[name] = options

    define_method(name) do
      foreign_key_value = self.send(options.foreign_key)
      model_class = options.model_class
      parent = model_class.where(id: foreign_key_value)
      parent.first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.name, options)
    define_method(name) do
      primary_key_value = self.send(options.primary_key)
      foreign_key_name = options.foreign_key
      model_class = options.model_class
      children = model_class.where({foreign_key_name => primary_key_value})
      children
    end
  end

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      through_table =  through_options.model_class.table_name
      through_item = through_options.class_name.downcase.to_sym

      source_options = through_options.model_class.assoc_options[source_name]
      source_table = source_options.model_class.table_name

      through_foreign_key = through_options.foreign_key
      value_for_fk = self.send(through_foreign_key)

      through_object = DBConnection.execute(<<-SQL, value_for_fk)
        SELECT
          #{source_table}.*
        FROM
          #{source_table}
        JOIN
          #{through_table} ON  #{source_options.foreign_key} = #{source_table}.#{through_options.primary_key}
        WHERE
          #{through_table}.#{through_options.primary_key} = ?
      SQL

      source_options.model_class.new(through_object.first)
    end
  end

  def assoc_options
    @options ||= {}
    @options
  end
end

class SQLObject
  extend Associatable
end
