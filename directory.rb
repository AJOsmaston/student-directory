@students = [] # an empty array accessable to all methods
@students_by_cohort = {} # an empty hash accessable to all methods
@name = " "

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
    cohort = student[:cohort]
    if @students_by_cohort[cohort] == nil
      @students_by_cohort[cohort] = []
    end
    @students_by_cohort[cohort].push(student[:name])
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(100)
end
 
def input_students
  months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  while @name != nil do
    puts "Please enter the name and cohort of the student in the format: Name, Month"
    @name, cohort = STDIN.gets.chomp.split(", ")
    if @name == nil && cohort == nil
        break
    end
    
    loop do
      
      if cohort == nil || cohort.length == 0
        cohort = "September"
      elsif !months.include?(cohort)
        puts "Error! #{cohort} is not a valid month. Please check your spelling and try again!"
        puts "Please enter the name and cohort of the student in the format: Name, Month"
        @name, cohort = STDIN.gets.chomp.split(", ")
      else
        break
      end
    end
    
    if @name.split("").length < 12
      @students << {name: @name, cohort: cohort.to_sym}
      if @students.count == 1
        puts "Now we have 1 student"
      else
        puts "Now we have #{@students.count} students"
      end
    else
      puts "Error: Name must be less than 12 characters"
    end
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  group_students_cohort
  print_student_list
  print_footer
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
    file = File.open(filename, "r")
    file.readlines.each do |line|
      name, cohort = line.chomp.split(",")
      @students << {name: name, cohort: cohort.to_sym}
    file.close
  end
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exist?(filename)
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def process(selection)
  case selection
    when "1"
      puts "Selected: input students"
      input_students
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
      load_students
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
