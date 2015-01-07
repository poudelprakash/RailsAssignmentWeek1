class Employee < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  validates :phone, format: {with: /\A9.\d{8}\z/,message: "phone number should be of 10 digit and start with 9 " }
  validates :salary, :numericality => {:greater_than_or_equal_to => 0}
  validates :email, format: {with: /\A[a-zA-Z][_.a-z0-9A-Z]+@[a-z0-9A-Z]+.[.a-zA-Z]+\z/,message: "Enter valid email address " },uniqueness: true
  after_validation :set_naming_format
  before_destroy :confirm_deletion

  def self.sort_by_first_name
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

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  def update_phone(value)
    self.phone=value
    self.save
  end

  protected
  def set_naming_format
    self.first_name = self.first_name.downcase.capitalize
    if self.middle_name!=nil
      self.middle_name = self.middle_name.downcase.capitalize
    end
    self.last_name = self.last_name.downcase.capitalize
  end

  def confirm_deletion
    puts 'Are you sure you want to delete'
    input = gets
    if(input=='y' || input=='Y')
      return true
    else
      p "Delete Cancelled"
      return false
    end
  end

end
