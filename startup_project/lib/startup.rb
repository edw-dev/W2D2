require "employee"

class Startup
  attr_reader :name,:funding, :salaries, :employees
  def initialize(name, funding, salaries)
    @name = name
    @funding = funding
    @salaries = salaries
    @employees = []
  end
  def valid_title?(title)
    return true if @salaries.has_key?(title)
    false
  end
  def >(other)
    return true if self.funding > other.funding
    false
  end
  def hire(employee_name, title)
    if self.valid_title?(title)
      @employees << Employee.new(employee_name, title)
    else
      raise "title is invalid!"
    end
  end
  def size
    @employees.length
  end
  def pay_employee(emp)
    salary = @salaries[emp.title]
    if @funding > salary
      emp.pay(salary) 
      @funding -= salary
    else
      raise "not enough funding"
    end
  end
  def payday
    @employees.each {|emp| pay_employee(emp)}
  end
  def average_salary
    sum = 0
    @employees.each {|emp| sum += @salaries[emp.title]}
    sum/(self.size * 1.0)
  end
  def close
    @employees = []
    @funding = 0
  end
  def acquire(other)
    @funding += other.funding
    other.salaries.each {|k, v| @salaries[k]=v if !@salaries.has_key?(k)}
    other.employees.each {|emp| @employees << emp}
    other.close
  end


end
