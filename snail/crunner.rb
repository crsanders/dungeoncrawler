require_relative 'cardinal.rb'

class Runner
  attr_accessor :current_room
  attr_accessor :current_floor
  @@display_help_message_once = true

  def initialize(loaded)
    if @@display_help_message_once
      puts 'Type "help" for a list of commands!'
      @@display_help_message_once = false
    end
    @current_room = 0
    @current_status = :enter
    if loaded
      player_data = JSON.parse(IO.read('player_save_data.json'))
      @current_room = player_data["current_room"]
      @current_floor = Marshal.load(File.read('floor_save_data.txt'))
      @current_floor.load_floor_number(player_data["current_floor"])
      play
    else
      @current_floor = FloorHandler.new
      play
    end
  end

  def play
    while true
      if @current_status == :advance
        temp_room_num = @current_room
        @current_room = @current_floor.play_room(@current_room, @current_status)
        if temp_room_num != @current_room
          @current_status = :enter
        else
          @current_status = action
        end
      elsif @current_status == :health
        Cardinal::PLAYER.current_health
        @current_status = action
      elsif @current_status == :inventory
        Cardinal::PLAYER.current_inventory
        @current_status = action
      elsif @current_status == :attack_status
        Cardinal::PLAYER.current_attack
        @current_status = action
      elsif @current_status == :defense_status
        Cardinal::PLAYER.current_defense
        @current_status = action
      elsif @current_status == :player_status
        Cardinal::PLAYER.player_status
        @current_status = action
      else
        @current_floor.play_room(@current_room, @current_status)
        @current_status = action
      end
    end
  end

  def prompt
    print "> "
  end

  def action
    prompt; user_input = gets.chomp
    if user_input == "advance" || user_input == "ad"
      :advance
    elsif user_input == "attack" || user_input == "at"
      :attack
    elsif user_input == "loot"
      :loot
    elsif user_input == "enter"
      :enter
    elsif user_input == "health"
      :health
    elsif user_input == "inventory" || user_input == "bag"
      :inventory
    elsif user_input == "status"
      puts "Room or Player status?"
      prompt; user_input = gets.chomp
      if user_input == "player" || user_input == "p"
        :player_status
      elsif user_input == "room" || user_input == "r"
        :room_status
      else
        puts "Input not recognized"
        action
      end
    elsif user_input == "room status"
      :room_status
    elsif user_input == "attack status" || user_input == "attack stat"
      :attack_status
    elsif user_input == "defense status" || user_input == "defense stat"
      :defense_status
    elsif user_input == "player status"
      :player_status
    elsif user_input == "help"
      help
      action
    elsif user_input == "exit"
      Process.exit(0)
    elsif user_input == "save"
      SaveGame.new(@current_room, @current_floor, @current_floor.floor_num)
      action
    elsif user_input == "debug"
      :debug
    else
      puts "Input not recognized"
      action
    end
  end

  def help
    puts "Advance - Attempts to advance to the next room/floor.  Fails if there are enemies in the room"
    puts "Attack - Attacks the enemy.  If there are multiple enemies in the room you will be prompted to select which enemy to attack"
    puts "Loot - Gathers the loot in the current room.  Fails if there is no loot in the room"
    puts "Status - Shows either player or room status"
    puts "Save - Saves the game"
    puts "Exit - Closes the game"
    puts "Help - Displays this screen"
    puts "NOTE: ALL COMMANDS MUST BE IN LOWER CASE"
  end

end

