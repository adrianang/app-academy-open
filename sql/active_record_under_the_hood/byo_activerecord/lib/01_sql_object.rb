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
          #{ self.table_name }.*
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
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{ self.table_name }
    SQL

    self.parse_all(results)
  end

  def self.parse_all(results)
    array_of_results = []
    results.each { |result| array_of_results << self.new(result) }
    array_of_results
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL, id)
      SELECT
        #{ self.table_name}.*
      FROM
        #{ self.table_name }
      WHERE
        ? = #{ self.table_name }.id
    SQL

    self.parse_all(result).first
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
    attr_values = []
    self.class.columns.each do |col_name|
      attr_values << self.send(col_name)
    end
    attr_values
  end

  def insert
    col_names = self.class.columns.join(", ")
    question_marks = Array.new(self.attribute_values.length, "?").join(", ")
    
    DBConnection.execute(<<-SQL, *self.attribute_values)
      INSERT INTO
        #{ self.class.table_name } (#{ col_names })
      VALUES
        (#{ question_marks })
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_line = self.class.columns.map { |col_name| "#{ col_name } = ?" }.join(", ")
    
    DBConnection.execute(<<-SQL, *self.attribute_values, id)
      UPDATE
        #{ self.class.table_name }
      SET
        #{ set_line }
      WHERE
        id = ?
    SQL
  end

  def save
    self.id.nil? ? self.insert : self.update
  end
end
