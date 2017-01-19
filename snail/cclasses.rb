require_relative 'cardinal.rb'

class SelectClass

  def initialize
    class_descriptions
    select_class
  end

  def class_descriptions
    puts "Select your class:"
    puts "1) Fighter - Balanced HP, Attack, and Defense"
    puts "2) Barbarian - High HP and Attack, low Defense"
    puts "3) Knight - High HP and Defense, low Attack"
    puts "4) Thief - High Crit, low HP, Attack, and Defense"
  end

  def select_class
    print "> "; user_input = gets.chomp
    if user_input == "1" || user_input == "fighter"
      Cardinal::PLAYER.starting_class(:fighter)
    elsif user_input == "2" || user_input == "barbarian"
      Cardinal::PLAYER.starting_class(:barbarian)
    elsif user_input == "3" || user_input == "knight"
      Cardinal::PLAYER.starting_class(:knight)
    elsif user_input == "4" || user_input == "thief"
      Cardinal::PLAYER.starting_class(:thief)
    elsif user_input == "exit"
      Process.exit(0)
    else
      puts "Input not recognized."
      class_descriptions
      select_class
    end
  end

end

