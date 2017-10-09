class Employee
  attr_accessor :salary

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    boss.add_employee(self) if !boss.nil?
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_accessor :subs

  def initialize(name, title, salary, boss = nil)
    super(name,title,salary,boss)
    @subs = []
  end

  def bonus(multiplier)
    sum = sum_subs_salary(@subs)
    sum * multiplier
  end

  def add_employee(employee)
    @subs << employee
  end

  private

  def sum_subs_salary(array)
    return 0 if array.length <= 0
    sum = 0
    array.each do |employee|
      if employee.is_a?(Manager)
        sum+= sum_subs_salary(employee.subs) + employee.salary
      else
        sum+= employee.salary
      end
    end
    sum
  end
end


daryl = Manager.new("Daryl","Top dawg", 100000, nil)
ed = Manager.new("Ed", "Manager", 20000, daryl)
janitor1 = Manager.new("john", "janitor1", 10000, ed)
janitor2 = Employee.new("mike", "Janitor2", 10000, janitor1)
junior_janitor = Employee.new("Stevie", "janitor", 2000, janitor1)
