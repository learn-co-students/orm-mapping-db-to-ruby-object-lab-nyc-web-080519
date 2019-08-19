class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object given a row from the database
    student = self.new
    student.id = row[0]
    student.name = row[1]
    student.grade = row[2]
    student
  end

  def self.all
    # retrieve all the rows from the "Students" database
     sql = << -SQL
      SELECT * 
      FROM students
     SQL
    # remember each row should be a new instance of the Student class
    # do iteration
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end 

  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
    sql = << -SQL
    SELECT * FROM students WHERE Student.name = ? LIMIT 1
    sql
    DB[:conn].execute (sql, name).map do |row| 
      self.new_from_db(row)
    end.first
  
  end
  
  def save
    sql = << -SQL
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

  def self.all_student_in_grade_9
    sql = << -SQL
      SELECT * FROM students 
      WHERE grade = 9

      # convert to object - call .new_from_db

  end

  def self.students_below_12th_grade
    sql = << -SQL
    SELECT * FROM students
    WHERE grade < 12

    # covert to object - call .new_from_db

  end

  def self.first_X_students_in_grade_10(number_of_students)
    sql = << -SQL
    SELECT * FROM students
    WHERE grade = 10 

    # covvert to object - call .new_from_db

  end

  def self.first_student_in_grade_10
  
    sql = << - SQL
    SELECT * FROM students
    WHERE grade = 10

    # covert to object - call .new_from_db


  end

  def self.all_students_in_grade_X(grade)

    sql == < -SQL
    SELECT * FROM students
    WHERE grade 


  end

end