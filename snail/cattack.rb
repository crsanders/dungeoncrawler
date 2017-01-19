require_relative 'cardinal.rb'

class Attack
  attr_accessor :check_deaths
  attr_accessor :target

  def initialize
    @target = nil
    @check_deaths = false
  end

  def choose_target(mobs)
    @mobs = mobs
    if mobs.empty?
      puts "No monsters to attack!"
    elsif mobs.length == 1
      @target = 0
      attack_target(@target, :player)
    elsif mobs.length == 2
      puts "Select which monster to attack (1 or 2):"
      print "> "; @target = gets.chomp
      if @target == "1"
        @target = 0
        attack_target(@target, :player)
      elsif @target == "2"
        @target = 1
        attack_target(@target, :player)
      else
        puts "Unexpected input!"
        choose_target(@mobs)
      end
    elsif mobs.length == 3
      puts "Select which monster to attack (1, 2, or 3):"
      print "> "; @target = gets.chomp
      if @target == "1"
        @target = 0
        attack_target(@target, :player)
      elsif @target == "2"
        @target = 1
        attack_target(@target, :player)
      elsif @target == "3"
        @target = 2
        attack_target(@target, :player)
      else
        puts "Unexpected input!"
        choose_target(@mobs)
      end
    else
      puts "Attempting to choose a target broke"
    end
  end

  def attack_target(target, origin) 
    if origin == :player
      damage = (1 + (rand(Cardinal::PLAYER.attack)).to_i) - (rand(@mobs[target].mob_defense)).to_i
      chance_to_crit = 1 + rand(100)
      if damage <= 0
        damage = 1
      end
      if chance_to_crit <= Cardinal::PLAYER.crit_chance
        crit = true
        damage = damage * 2
      else
        crit = false
      end
      @mobs[target].mob_health = @mobs[target].mob_health - damage
      if crit
        puts "You critically hit the monster, dealing #{damage} points of damage!"
      else
        puts "You attack the monster, dealing #{damage} points of damage!"
      end
      if @mobs[target].mob_health <= 0
        puts "You defeated the monster!"
        xp = 1 + rand(@mobs[target].mob_level)
        if @mobs[target].is_rare?
          xp = xp * 2
        end
        puts "You gain #{xp} XP!"
        Cardinal::PLAYER.xp += xp
        if Cardinal::PLAYER.xp >= Cardinal::PLAYER.xp_to_level
          Cardinal::PLAYER.level_up
        end
        @check_deaths = true
      end
    elsif origin == :mob
      damage = (1 + (rand(@mobs[target].mob_attack)).to_i) - (rand(Cardinal::PLAYER.defense)).to_i
      if damage <= 0
        damage = 0
      end
      Cardinal::PLAYER.health = Cardinal::PLAYER.health - damage
      puts "You are attacked by monster ##{target + 1}, taking #{damage} points of damage!"
      if Cardinal::PLAYER.health <= 0
        puts "You are defeated!"
        puts; puts; puts
        puts "GAME OVER"
        main_menu = MainMenu.new
        Cardinal::PLAYER.reset
        FloorHandler.reset
        main_menu.play
      end
    end
  end

end

