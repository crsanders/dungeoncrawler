require_relative 'cardinal.rb'

class Monster
  attr_accessor :mob_health
  attr_reader :mob_attack
  attr_reader :mob_defense
  attr_reader :rare_mob
  attr_reader :mob_level
  attr_reader :mob_name

  def initialize(current_floor, current_room)
    @rare_mob = false
    chance = 1 + rand(100)
    case chance
    when 1..90
      @rare_mob = false
    when 91..100
      @rare_mob = true
    end
    generate_mob(current_floor, current_room)
    if @rare_mob
      tmp_level = @mob_level
      tmp_health = @mob_health
      tmp_attack = @mob_attack
      tmp_defense = @mob_defense
      generate_mob(current_floor, current_room)
      @mob_level += tmp_level
      @mob_health += tmp_health
      @mob_attack += tmp_attack
      @mob_defense += tmp_defense
    end
  end

  def generate_mob(current_floor, current_room)
    difficulty = 1 + rand(Cardinal::PLAYER.level)
    @mob_level = 1 + rand(current_floor) + (0.1 * rand(current_room)).round
    @mob_health = (1 + rand(5)) * (difficulty + rand(@mob_level))
    @mob_attack = (1 + rand(5)) * (difficulty + rand(@mob_level))
    @mob_defense = (1 + rand(5)) * (difficulty + rand(@mob_level))
  end

  def is_rare?
    @rare_mob
  end

end

