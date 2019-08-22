require_relative "employees"

ned = Manager.new("Ned", "Founder", 1000000)
darren = Manager.new("Darren", "TA Manager", 78000, ned)
shawna = Employee.new("shawna", "TA", 12000, darren)
david = Employee.new("David", "TA", 10000, darren)

puts ned.bonus(5)
puts darren.bonus(4)
puts david.bonus(3)