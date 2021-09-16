def print_header
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100)
end

def print(students)

  students_by_cohort = {}
  students.each do |student|
    cohort = student[:cohort]
    
    if students_by_cohort[cohort] == nil
      students_by_cohort[cohort] = []
    end
    students_by_cohort[cohort].push(student[:name])
  end
  
  
  students_by_cohort.sort.each do |month, names|
    puts "#{month} Cohort".center(100)
    names.each do |name| 
      puts "#{name}".center(100)
    end
  end
  
  return students
  
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(100)
end
 
def input_students
  name = " "
  students = []
  months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  while !name.empty? do
    puts "Please enter the name and cohort of the student in the format: Name, Month"
    name_and_cohort = gets.chomp
    name = name_and_cohort.split(", ")[0]
    cohort = name_and_cohort.split(", ")[1]
    if name_and_cohort.empty?
        break
    end
    
    loop do
      
      if cohort == nil || cohort.length == 0
        cohort = "September"
      elsif !months.include?(cohort)
        puts "Error! #{cohort} is not a valid month. Please check your spelling and try again!"
        puts "Please enter the name and cohort of the student in the format: Name, Month"
        name_and_cohort = gets.chomp
        name = name_and_cohort.split(", ")[0]
        cohort = name_and_cohort.split(", ")[1]
      else
        break
      end
    end
    
    if name.split("").length < 12
      puts "Please enter any hobbies that the student has"
      hobby = gets.chomp
      puts "Please enter student country of birth"
      birth = gets.chomp
      puts "Please enter student height"
      height = gets.chomp
      students << {name: name, hobby: hobby, birth: birth, height: height, cohort: cohort.to_sym}
      if students.count == 1
        puts "Now we have 1 student"
      else
        puts "Now we have #{students.count} students"
      end
    else
      puts "Error: Name must be less than 12 characters"
    end
  end
  # return the array of students
  students
end

def interactive_menu
  students = []
  loop do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    selection = gets.chomp
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit
    else
      puts "I don't know what you meant, try again!"
    end
  end
end

interactive_menu
