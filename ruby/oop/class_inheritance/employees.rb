class Employee
  attr_accessor :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
    bonus
  end
end

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss)
    super(name, title, salary, boss)
    @employees = []
  end

  def bonus(multiplier)
    total_salaries = 0

    queue = [self]
    until queue.empty?
      manager = queue.shift
      manager.employees.each do |employee|
        if employee.instance_variable_defined?(:@employees)
          queue << employee
        end

        total_salaries += employee.salary
      end
    end

    total_salaries * multiplier
  end
end