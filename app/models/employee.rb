class Employee < ActiveRecord::Base
  def self.sortByFirstName
    self.order(first_name: :asc)
  end
  def self.statistics
    p "The average salary of employees is: #{self.average(:salary)}"
    p "The sum of salary of employees is: #{self.sum(:salary)}"
    p "The minimum salary of employees is: #{self.minimum(:salary)}"
    p "The maximum salary of employees is: #{self.maximum(:salary)}"
  end
  def self.truncate
    self.delete_all
    p "deleted all data successfully"
  end
  def fullName
    p "#{self.first_name} #{self.last_name}"
  end
  def updatePhone(value)
    self.phone=value
    self.save
  end


end
