class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      name_format = "@#{ name }"

      define_method(name) do
        self.instance_variable_get(name_format)
      end

      define_method("#{ name }=") do |val|
        self.instance_variable_set(name_format, val)
      end
    end
  end
end
