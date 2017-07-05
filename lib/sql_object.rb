require 'active_support/inflector'
require_relative 'db_connection'
require_relative 'searchable'
require_relative 'instance_actions'
require_relative 'queries'
require_relative 'associatable'

class SQLObject
  include InstanceActions
  #insert
  #update
  #save

  extend Queries
  #first
  #last
  #retrieve_columns
  #all

  extend Searchable
  #where
  #find

  extend Associatable
  #belongs_to
  #has_many
  #has_one_through

  def initialize(params = {})
    params.each do |attr_name, value|
      raise "unknown attribute '#{attr_name.to_s}'" unless self.class.columns.include?(attr_name.to_sym)
      self.send("#{attr_name}=".to_sym, value)
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.columns
    @columns || self.retrieve_columns
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.parse_all(results)
    results.map do |datum|
      self.new(datum)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map {|col_name| self.send(col_name.to_sym)}
  end

  private

  def self.finalize!
    columns.each do |column|
      define_method(column) do
        attributes[column]
      end
      define_method("#{column}=".to_sym) do |val|
        attributes[column.to_sym] = val
      end
    end
  end
end

TracePoint.new(:end) do |tp|
  klass = tp.binding.receiver
  klass.finalize! if klass.respond_to?(:finalize!)
end.enable
