require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    self.class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = "#{ name }_id".to_sym
    @primary_key = :id
    @class_name = "#{ name.to_s.camelcase }"

    options.each { |attribute, val| self.send("#{ attribute }=", val) } if options
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = "#{ self_class_name.downcase }_id".to_sym
    @primary_key = :id
    @class_name = "#{ name.to_s.singularize.camelcase }"

    options.each { |attribute, val| self.send("#{ attribute }=", val) } if options
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    
    define_method(name) do
      foreign_key_value = send(options.foreign_key)
      model_class = options.model_class
      
      model_class.where(options.primary_key => foreign_key_value).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.name, options)

    define_method(name) do
      foreign_key_value = send(options.primary_key)
      model_class = options.model_class

      model_class.where(options.foreign_key => foreign_key_value)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
