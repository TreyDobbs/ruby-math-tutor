#!/usr/local/bin/ruby -w
# This Ruby program will allow the user to choose between addition, subtraction,
# multiplication, and division problems. There will be six functions, one to
# display a menu, four for the arithmetic problems, and one to quit from the
# menu and exit the program. The arithmetic problems will have three levels
# of difficulty to select from. If a user chooses to quit from the menu it will
# display the number of problems calculated correctly, the number attempted, and
# the percentage correct. 
# Written by Trey Dobbs

# rand(Min..MAX) is used to generate random number between Min and MAX both inclusive
# rand(Min...MAX) is used to generate random number between Min and MAX excluding the MAX value


# helper method to get first number based on current difficulty and arithmetic operation
def get_first_random_number difficulty, operation
  if difficulty == 1
    if  operation == 4
      return [2,4,6,8,9,10].sample
    else
      return rand(0..10)
    end
  elsif  difficulty == 2
    return rand(0..100)
  elsif difficulty == 3
    return rand(-100..100)
  end
end

# helper method to get second number based on current difficulty, arithmetic operation,
# and first random number
def get_second_number difficulty, operation, first_number
  if difficulty == 1
    if operation == 2
      return rand(0..first_number)
    elsif  operation == 4
      if first_number == 9 or first_number == 6
        return 3
      else
        return 2
      end
    else
      return rand(0..10)
    end
  elsif  difficulty == 2
    if operation == 4
      return rand(1..100)
    else
      return rand(0..100)
    end
  elsif difficulty == 3
    if operation == 4
      while true
        number = rand(-100..100)
        if number != 0
          return number
        end
      end
    else
        return rand(-100..100)
    end
  end
end

# gets the difficulty for the question
# Easy => 1, Medium => 2, Hard => 3
def get_the_level
  while true
    puts 'Enter your difficulty choice (E for Easy) - (M for Medium) - (H for Hard)'
    choice = gets.chomp
    if choice.downcase == 'e'
      return 1
    elsif choice.downcase == 'm'
      return 2
    elsif choice.downcase == 'h'
      return 3
    else
      puts 'Please enter a valid choice'
    end
  end
end

# displays menu and gets the menu choice
# Addition => 1, Subtraction => 2, Multiplication => 3, Division => 4
# Update Difficulty => 5, Quit => 6
def display_menu
  puts '1 - Addition'
  puts '2 - Subtraction'
  puts '3 - Multiplication'
  puts '4 - Division'
  puts '5 - Set Difficulty (Default Easy)'
  puts '6 - Quit'
  while true
    puts 'Enter your choice: '
    choice = gets.chomp.to_i
    if choice >= 1 and choice <= 6
      return choice
    else
      puts 'Please enter a valid choice between 1-6'
    end
  end
end

# generates two random numbers based on the difficulty, asks for the sum of
# numbers, and shows user whether the answer is correct or not
# returns 1 in the event the answer is correct, otherwise 0
def addition difficulty
  first_num = get_first_random_number  difficulty, 1
  second_num = get_second_number difficulty, 1, first_num

  print "What is #{first_num} + #{second_num}? "
  answer = gets.chomp.to_i

  if answer == (first_num + second_num)
    puts "You guessed it CORRECT the answer is #{answer}"
    return 1
  else
    puts "You guessed it WRONG, correct answer is #{first_num + second_num}"
    return 0
  end
end

# generates two random numbers based on the difficulty, asks for the subtraction
# of numbers, and shows the user whether the answer is correct or not
# returns 1 in the event the answer is correct, otherwise 0
def subtraction difficulty
  first_num = get_first_random_number  difficulty, 2
  second_num = get_second_number difficulty, 2, first_num
  print "What is #{first_num} - #{second_num}? "
  answer = gets.chomp.to_i

  if answer == (first_num - second_num)
    puts "You guessed it CORRECT the answer is #{answer}"
    return 1
  else
    puts "You guessed it WRONG, correct answer is #{first_num - second_num}"
    return 0
  end
end

# generates two random numbers based on the difficulty, asks for the 
# multiplication of numbers, and shows user whether the answer is correct or not
# returns 1 in the event the answer is correct, otherwise 0
def multiplication difficulty
  first_num = get_first_random_number  difficulty, 3
  second_num = get_second_number difficulty, 3, first_num

  print "What is #{first_num} * #{second_num}? "
  answer = gets.chomp.to_i

  if answer == (first_num * second_num)
    puts "You guessed it CORRECT the answer is #{answer}"
    return 1
  else
    puts "You guessed it WRONG, correct answer is #{first_num * second_num}"
    return 0
  end
end

# generates two random numbers based on the difficulty, asks for the division of
# numbers, and shows the user whether the answer is correct or not
# returns 1 in the event the answer is correct, otherwise 0
def division difficulty
  first_num = get_first_random_number  difficulty, 4
  second_num = get_second_number difficulty, 4, first_num

  print "What is #{first_num} / #{second_num}? "
  answer = gets.chomp.to_f.round 2
  actual = (first_num.to_f / second_num.to_f).round 2

  if answer == actual
    puts "You guessed it CORRECT the answer is #{answer}"
    return 1
  else
    puts "You guessed it WRONG, correct answer is #{first_num / second_num}"
    return 0
  end
end

# main function that keeps asking user for an arithmetic operation they want to
# perform until the user chooses to quit. Also keeps track of total attempts and
# correct attempts. When user quits, it will display the user their total 
# attempts and accuracy.
def main
  no_of_attempts = 0
  correct_answers = 0
  difficulty = 1
  while true
    choice = display_menu
    if choice == 1
      no_of_attempts += 1
      correct_answers += addition difficulty
    elsif choice == 2
      no_of_attempts += 1
      correct_answers += subtraction difficulty
    elsif choice == 3
      no_of_attempts += 1
      correct_answers += multiplication difficulty
    elsif choice == 4
      no_of_attempts += 1
      correct_answers += division difficulty
    elsif choice == 5
      difficulty = get_the_level
    else
      break
    end
    printf "\n"
  end
  if  no_of_attempts == 0
    puts 'You attempted 0 questions and your accuracy is 0%'
  else
    accuracy = ((correct_answers.to_f/no_of_attempts.to_f)*100).round 2
    puts "You attempted #{no_of_attempts} and your accuracy is #{accuracy}%"
  end
end

# calling main function
main
