play = true

# read file
def list(name_file)
  file_data = File.open(name_file)
  list_data = file_data.readlines.map(&:chomp)
  file_data.close
  puts list_data
end

while play

  # strings to array
  students = []
  File.open('student.txt').each_line do |line|
    students.push(line.chomp)
  end

  puts 'Студенты: '
  list('student.txt')

  puts ''

  print 'Enter Age: '
  age = gets.chomp

  # Search for a match
  list_result_student = File.open('result.txt').readlines.map(&:chomp).select { |item| item.include?(age) }
  find_student = File.open('student.txt').readlines.map(&:chomp).select { |item| item.include?(age) }
  if find_student.any?
    if list_result_student.none?
      puts find_student
      File.open('result.txt', 'a') { |f| find_student.each { |element| f.puts(element) } }
    else
      puts 'Student in base'
    end
  else
    puts 'No student'
    end

  # strings to array
  result = []
  File.open('result.txt').each_line do |line|
    result.push(line.chomp) # if you need '\n' then ommit chomp
  end

  if result.size == students.size
    play = false
  else
    puts ''
    puts 'If you exit program, enter -1'
    exit = gets.to_i
    puts ''
    if exit == -1
      list('result.txt')
      play = false
    end
    end

end