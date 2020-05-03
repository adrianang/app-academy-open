require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    if @columns
      return @columns
    else
      get_columns = DBConnection.execute2(<<-SQL).first
        SELECT
          *
        FROM
          #{ self.table_name }
      SQL

      @columns = get_columns.map(&:to_sym)
    end
  end

  def self.finalize!
    self.columns.each do |column_name|
      define_method(column_name) { self.attributes[column_name] }
      define_method("#{ column_name }=") { |val| self.attributes[column_name] = val }
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.tableize
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      symbolized_attr_name = attr_name.to_sym

      if !self.class.columns.include?(symbolized_attr_name)
        raise "unknown attribute '#{ attr_name }'"
      else
        self.send("#{ attr_name }=", value)
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
