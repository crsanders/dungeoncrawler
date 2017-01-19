require_relative 'cardinal.rb'

class MainMenu

  def initialize
    puts; puts; puts;
    puts "Welcome to Dungeon Crawler!"
  end

  def prompt
    print "> "
  end

  def select
    prompt; action = gets.chomp
    if action == "1" || action == "start"
       start
    elsif action == "2" || action == "load"
       load_game
    elsif action == "3" || action == "about"
       about
    elsif action == "exit" || action == "4"
       Process.exit(0)
    else
       confused
    end
  end

  def start
    SelectClass.new
    Runner.new(false)
  end

  def load_game
    player_data = JSON.parse(IO.read('player_save_data.json'))
    Cardinal::PLAYER.load_player(player_data["max_health"], player_data["health"], player_data["attack"], player_data["defense"], player_data["level"], player_data["xp"], player_data["xp_to_level"], player_data["crit_chance"])
    Runner.new(true)
  end

  def about
    puts "Created by Christian Sanders as an attempt to learn Ruby."
    puts
  end

  def confused
    puts "Input not recognized"
    puts
  end

  def play
    while true
      puts "1) New Game\n2) Load\n3) About\n4) Exit"
      select
    end
  end

end

