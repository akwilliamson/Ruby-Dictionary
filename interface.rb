require './lib/term'
require './lib/word'
puts "----------------------------------"
puts "Welcome to the Dictionary Master! "
puts "----------------------------------"
puts "\n"

@current_term
@current_word

def main_menu
  puts "Main Menu"
  puts "---------"
  puts "Press 't' to add a new term name:"
  puts "Press 'l' to list all of your terms:"
  puts "Press 'x' to exit the Dictionary Master:"
  puts "Press 's' to search for a term:"
  user_input = gets.chomp
  if user_input == 't'
    add_term
  elsif user_input == 'l'
    view_terms
  elsif user_input == 's'
    search_terms
  elsif user_input == 'x'
    puts "Are you really sure? Type 'y' to quit or 'n' to not quit"
    user_sure = gets.chomp
      if user_sure == 'y'
        puts "Later!"
      elsif user_sure == 'n'
        main_menu
      else
        puts "invalid"
      end
  else
    puts "that is an invalid entry"
    main_menu
  end
end

def add_term
  puts "Enter the term name"
  input_name = gets.chomp
  puts "Enter a language"
  input_language = gets.chomp
  puts "Enter the term definition"
  input_definition = gets.chomp

  new_word = Word.create(input_name.capitalize, input_language.capitalize)
  new_term = Term.create(new_word, input_definition)
  puts "\n"
  puts "#{new_word.name} created. \n"
  puts "\n"
  main_menu
end

def view_terms
  if Term.all.empty?
    puts "\n"
    puts "Term list empty.  Create a term first. \n\ "
    main_menu
  else
    puts "\n"
    puts "Dictionary"
    puts "----------"
    Term.all.each_with_index do |word, index|
      puts "#{index + 1}. #{word.name[0].name}"
    end

    puts "\n"
    puts "Type the number of the term to view the definition."
    puts "Type 'd' to delete a term."
    puts "Type 'm' to return to main menu."
    user_input = gets.chomp
    if user_input == 'd'
      delete_term
    elsif user_input == 'm'
      main_menu
    elsif user_input.to_i > 0
      # @current_word = Word.all[user_input.to_i]
      @current_term = Term.all[user_input.to_i - 1]
      puts "\n"
      @current_term.name.each do |name|
        print "#{name.name.capitalize}, "
      end
      puts "\n"
      @current_term.definition.each_with_index do |definition, index|
        puts "#{index + 1}.  #{definition}"
      end
      puts "\n"
      puts "Press 'e' to edit term or add additional definitions."
      puts 'Press "l" to list terms again or "m" to return to main menu.'
      user_choice = gets.chomp
      if user_choice == 'l'
        view_terms
      elsif user_choice == 'm'
        main_menu
      elsif user_choice == 'e'
        edit_def
      else
        main_menu
      end
    else
      puts "Invalid Choice."
      view_terms
    end
  end
end

def edit_def
  puts "\n"
  puts "What would you like to do to the term?"
  puts "Press 'e' to edit the a definition"
  puts "Press 'a' to add another definition to the term"
  puts "Press 'n' to add another name to the term"
  user_input = gets.chomp
  if user_input == 'e'
    @current_term.definition.each_with_index do |definition, index|
      puts "#{index+1}. #{definition}"
    end
    puts "Enter the number of the definition you'd like to edit"
    user_index = gets.chomp
    puts "Enter a new definition"
    user_definition = gets.chomp
    @current_term.edit_definition((user_index.to_i - 1), user_definition)
    puts "The definition of #{@current_term.name} is now #{@current_term.definition[user_index.to_i - 1]} \n\ "
    view_terms
  elsif user_input == 'a'
    puts "Enter another definition"
    another_definition = gets.chomp
    @current_term.add_definition(another_definition)
    puts "The new definition has been added to the term"
    view_terms
  elsif user_input == 'n'
    add_word
  end
end

def add_word
  puts "\n"
  puts "Enter the new word to add to the term:"
  user_word = gets.chomp
  puts "Enter the language of this word:"
  user_language = gets.chomp
  new_word = Word.create(user_word, user_language)
  @current_term.add_name(new_word)
  puts "#{new_word.name} added to #{@current_term.name[0].name}"
  view_terms
end

def delete_term
  puts "\n"
  puts "Type the number of the term to delete or 'n' to return to term list."
  user_input = gets.chomp

  if user_input == 'n'
    view_terms
  else
    Term.delete(user_input.to_i - 1)
    puts "Term deleted.\n\ "
    view_terms
  end
end

def search_terms
  if Term.all.empty?
    puts "Create a term first dude"
    main_menu
  else
    puts "Type the name of the term you want to find"
    term_name = gets.chomp
    if Term.search(term_name) == nil
      puts "\n"
      puts "There are no terms for that"
    else
      found_term = Term.search(term_name)
      puts "\n"
      puts "#{found_term.name}: "
      found_term.definition.each_with_index do |definition, index|
        puts "#{index + 1}.  #{definition}"
      end
    end
    puts "\n"
    puts "Search for another term? Press 'y' for yes"
    puts "Press any key to return to the main menu"
    user_input = gets.chomp
    if user_input == 'y'
      search_terms
    else
      main_menu
    end
  end
end

main_menu


