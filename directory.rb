# put the students into an array
# students = [
#   {name: "Dr. Hannibal Lecter", cohort: :november},
#   {name: "Darth Vader", cohort: :november},
#   {name: "Nurse Ratched", cohort: :november},
#   {name: "Michael Corleone", cohort: :november},
#   {name: "Alex DeLarge", cohort: :november},
#   {name: "The Wicked Witch of the West", cohort: :november},
#   {name: "Terminator", cohort: :november},
#   {name: "Freddy Krueger", cohort: :november},
#   {name: "The Joker", cohort: :november},
#   {name: "Joffrey Baratheon", cohort: :november},
#   {name: "Norman Bates", cohort: :november},
# ]

def print_header
  puts "The students of Villains Academy".center(200)
  puts "-------------".center(200)
end

def print(students)
  # students.each_with_index do |student, index|
  #   puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  # end
  
  students_by_cohort = {}
  students.each do |student|
    cohort = student[:cohort]
    
    if students_by_cohort[cohort] == nil
      students_by_cohort[cohort] = []
    end
    students_by_cohort[cohort].push(student[:name])
  end
  
  students_by_cohort.each do |month, names|
    puts "#{month} Cohort".center(200)
    names.each do |name| 
      puts "#{name}".center(200)
    end
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(200)
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
    
    puts "Please enter any hobbies that the student has"
    hobby = gets.chomp
    puts "Please enter student country of birth"
    birth = gets.chomp
    puts "Please enter student height"
    height = gets.chomp
    
    if name.split("").length < 12
      students << {name: name, hobby: hobby, birth: birth, height: height, cohort: cohort.to_sym}
      puts "Now we have #{students.count} students"
    else
      puts "Please enter a name less that 12 characters"
    end
  end
  # return the array of students
  students
end

# def select_letter(input)
#   puts "Please enter a letter to filter the students:"
#   letter = gets.chomp
#   student_array = []
  
#   input.each do |student|
#     if letter[0] == student[:name][0]
#       student_array << student
#     end
#   end
#   student_array
# end

students = input_students
print_header
print(students)
print_footer(students)

# student_array = select_letter(students)
# print_header
# print(student_array)
# print_footer(student_array)