require 'csv'

@students = [] # an empty array accessable to all methods
@students_by_cohort = {} # an empty hash accessable to all methods
@name = " "
@cohort = "September"

def print_header
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100)
end

def print_student_list
  @students_by_cohort.sort.each do |month, names|
    puts "#{month} Cohort".center(100)
    names.each do |name| 
      puts "#{name}".center(100)
    end
  end
end

def group_students_cohort
  @students_by_cohort.clear()
  @students.each do |student|
    @cohort = student[:cohort]
    if @students_by_cohort[@cohort] == nil
      @students_by_cohort[@cohort] = []
    end
    @students_by_cohort[@cohort].push(student[:name])
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(100)
end

def add_to_students
  @students << {name: @name, cohort: @cohort.to_sym}
end

def cohort_check(cohort)
  months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  if cohort == nil || cohort.length == 0
    @cohort = "September"
    "pass"
  elsif !months.include?(cohort)
    puts "Error! #{cohort} is not a valid month. Please check your spelling and try again!"
  else
    "pass"
  end
end

def length_check(name)
  if name.split("").length < 12
    "pass"
  else
      puts "Error: Name must be less than 12 characters"
  end
end
 
def input_students
    puts "Please enter the name and cohort of the student in the format: Name, Month"
    @name, @cohort = STDIN.gets.chomp.split(", ")
end

def pass_text
  if @students.count == 1
      puts "Now we have 1 student"
      "pass"
  else
      puts "Now we have #{@students.count} students"
      "pass"
  end
end

def input_control
  @name = " "
  loop do
    input_students
    if @name == nil && @cohort == nil
      break
    else
      if length_check(@name) == "pass" && cohort_check(@cohort) == "pass"
        add_to_students
        pass_text
      end
    end
  end
  
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save a list"
  puts "4. Load a list"
  puts "5. Clear current list"
  puts "9. Exit"
end

def show_students
  print_header
  group_students_cohort
  print_student_list
  print_footer
end

def save_students
  puts "Please enter the file name to save:"
  filename = STDIN.gets.chomp
  CSV.open(filename, "wb") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
end

def load_students(filename = "students.csv")
  CSV.foreach(filename) do |line|
    @name, @cohort = line
    add_to_students
  end
end

def try_load_students
  puts "Please enter the file name to load:"
  filename = STDIN.gets.chomp
  return if filename.nil?
  if File.exist?(filename)
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
  end
end

def clear_list
  @students_by_cohort.clear
  @students.clear
end

def process(selection)
  case selection
    when "1"
      puts "Selected: input students"
      input_control
    when "2"
      puts "Selected: show students"
      show_students
    when "3"
      puts "Selected: save students"
      save_students
    when "4"
      puts "Selected: load students"
      if !@students.empty?
        @students = []
      end
      try_load_students
    when "5"
      puts "Clearing list."
      clear_list
    when "9"
      exit
    else
      puts "I don't know what you meant, try again!"
  end
end
  
def interactive_menu()
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

load_students()
interactive_menu
