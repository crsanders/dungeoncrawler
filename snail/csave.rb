require_relative 'cardinal.rb'

class SaveGame

  def initialize(current_room, current_floor, current_floor_number)
    player_data = { "max_health" => Cardinal::PLAYER.max_health, "health" => Cardinal::PLAYER.health, "attack" => Cardinal::PLAYER.attack, "defense" => Cardinal::PLAYER.defense, "level" => Cardinal::PLAYER.level, "xp" => Cardinal::PLAYER.xp, "xp_to_level" => Cardinal::PLAYER.xp_to_level, "crit_chance" => Cardinal::PLAYER.crit_chance, "current_room" => current_room, "current_floor" => current_floor_number  }
    File.open('player_save_data.json', 'w') { |f| f.write(player_data.to_json) }
    File.open('floor_save_data.txt', 'w') { |f| f.write(Marshal.dump(current_floor)) }
    puts "Saved the game!"
  end

end

