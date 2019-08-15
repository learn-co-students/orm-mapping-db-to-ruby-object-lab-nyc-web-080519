
require 'pry'
class Student
  attr_accessor :id, :name, :grade

  def initialize
    # @id = id
    # @name = name
    # @grade = grade
  end  

  
  def self.all
    sql = <<-SQL
    SELECT * FROM students;
    SQL
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end  # ends map iterator
  end  # ends self.all method
  
  def self.new_from_db(row)
    new_student = self.new
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
    # binding.pry
    new_student
    # binding.pry
  end  # ends self.new_from_db method

  def self.find_by_name(sname)
    sql = <<-SQL
    SELECT * 
    FROM students
      WHERE name = ?;
    SQL
      
    DB[:conn].execute(sql, sname).map do |row|
      self.new_from_db(row)
    end.first  # ends map loop
  end  # ends self.find_by_name

  def self.all_students_in_grade_9
    sql = <<-SQL
      SELECT * FROM students WHERE grade = 9;
    SQL
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end  # ends .all_students_in_grade_9 method
    
  def self.students_below_12th_grade
    sql = <<-SQL
      SELECT * FROM students WHERE grade < 12;
    SQL
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end  # ends .students_below_12th_grade

  def self.first_X_students_in_grade_10(x)
    sql = <<-SQL
      SELECT * FROM students WHERE grade = 10 LIMIT ?;
    SQL
    DB[:conn].execute(sql, x).map do |row|
      self.new_from_db(row)
    end
  end  # ends .first_X_students_in_grade_10 method

  def self.first_student_in_grade_10
    sql = <<-SQL
      SELECT * FROM students WHERE grade = 10 LIMIT 1;
    SQL
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end.first
  end  # ends .first_X_students_in_grade_10 method

  def self.all_students_in_grade_X(x)
    sql = <<-SQL
      SELECT * FROM students WHERE grade = ?;
    SQL
    DB[:conn].execute(sql, x).map do |row|
      self.new_from_db(row)
    end  # ends map loop
  end  # ends all_students_in_grade_X method


  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
