require_relative 'cardinal.rb'

class ExitRoom < Room

  def initialize(floor)
    @boss_dead = false
    @floor = floor
  end

  def announce
    puts "You have found the final room of this floor!"
#    if @floor.between?(1, 5)
    if true
      xp = 1 + rand(@floor * 2)
      puts "You gain #{xp} XP!"
      Cardinal::PLAYER.xp += xp
      if Cardinal::PLAYER.xp >= Cardinal::PLAYER.xp_to_level
        Cardinal::PLAYER.level_up
      end
      puts "Carry on brave adventurer!"
      Cardinal::PLAYER.player_status
      @boss_dead = true
    else
      puts "A giant monster blocks your way!"
    end
  end

  def advance_floor
    if @boss_dead
      Runner.new(false)
    else
      puts "You must defeat the boss to advance!"
    end
  end

end

