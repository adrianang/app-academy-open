class Employee
  attr_accessor :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @boss.employees << self if @boss != nil
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
    bonus
  end
end

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss = nil)
    super(name, title, salary, boss)
    @employees = []
  end

  def bonus(multiplier)
    total_salaries = 0

    queue = [self]
    until queue.empty?
      manager = queue.shift
      manager.employees.each do |employee|
        queue << employee if employee.instance_variable_defined?(:@employees)
        total_salaries += employee.salary
      end
    end

    total_salaries * multiplier
  end
end