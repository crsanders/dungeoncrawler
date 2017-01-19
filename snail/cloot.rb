require_relative 'cardinal.rb'

class Loot

  def initialize(current_floor, current_room)
    @loot_type = determine_loot_type
    @loot_rarity = determine_loot_rarity
    @loot_name = "#{@loot_rarity} #{@loot_type} item"
    puts "You obtain a #{@loot_name}!"
    determine_loot_effect(current_floor, current_room)
  end

  def determine_loot_type
    type = 1 + rand(100)
    case type
    when 1..40
      :healing
    when 41..70
      :weapon
    when 71..99
      :armor
    when 100
      :legendary
    end
  end

  def determine_loot_rarity
    rarity = 1 + rand(100)
    case rarity
    when 1..75
      :common
    when 76..89
      :uncommon
    when 90..99
      :rare
    when 100
      :legendary
    end
  end

  def determine_loot_effect(current_floor, current_room)
    case @loot_type
    when :healing
      case @loot_rarity
      when :common
        health = (1 + (rand(current_floor + (0.1 * current_room))).round)
        Cardinal::PLAYER.gain_health(health)
        puts "You heal for #{health} points!"
      when :uncommon
        health = (5 + (rand(current_floor + (0.1 * current_room))).round)
        Cardinal::PLAYER.gain_health(health)
        puts "You heal for #{health} points!"
      when :rare
        health = (10 + (rand(current_floor * 2 + (0.1 * current_room))).round)
        max_health = (5 + (rand(current_floor + (0.1 * current_room))).round)
        Cardinal::PLAYER.max_health += max_health
        Cardinal::PLAYER.gain_health(health)
        puts "Your max health goes up by #{max_health} points!"
        puts "You heal for #{health} points!"
      when :legendary
        max_health = (15 + (rand(current_floor * 2 + (0.1 * current_room))).round)
        Cardinal::PLAYER.max_health += max_health
        Cardinal::PLAYER.health = Cardinal::PLAYER.max_health
        puts "Your max health goes up by #{max_health} points!"
        puts "You heal to full!"
      end
    when :weapon
      case @loot_rarity
      when :common
        attack = (1 + (rand(current_floor + (0.1 * current_room))).round)
        Cardinal::PLAYER.attack += attack
        puts "You gain #{attack} attack points!"
      when :uncommon
        attack = (3 + (rand(current_floor + (0.1 * current_room))).round)
        Cardinal::PLAYER.attack += attack
        puts "You gain #{attack} attack points!"
      when :rare
        attack = (5 + (rand(current_floor + (0.1 * current_room))).round)
        Cardinal::PLAYER.attack += attack
        puts "You gain #{attack} attack points!"
      when :legendary
        attack = (10 + (rand(current_floor * 2 + (0.1 * current_room))).round)
        Cardinal::PLAYER.attack += attack
        puts "You gain #{attack} attack points!"
      end
    when :armor
      case @loot_rarity
      when :common
        defense = (1 + (rand(current_floor + (0.1 * current_room))).round)
        Cardinal::PLAYER.defense += defense
        puts "You gain #{defense} defense points!"
      when :uncommon
        defense = (3 + (rand(current_floor + (0.1 * current_room))).round)
        Cardinal::PLAYER.defense += defense
        puts "You gain #{defense} defense points!"
      when :rare
        defense = (5 + (rand(current_floor + (0.1 * current_room))).round)
        Cardinal::PLAYER.defense += defense
        puts "You gain #{defense} defense points!"
      when :legendary
        defense = (10 + (rand(current_floor * 2 + (0.1 * current_room))).round)
        Cardinal::PLAYER.defense += defense
        puts "You gain #{defense} defense points!"
      end
    when :legendary
      case @loot_rarity
      when :common
        health = (1 + (rand(current_floor + (0.1 * current_room))).round)
        attack = (1 + (rand(current_floor + (0.1 * current_room))).round)
        defense = (1 + (rand(current_floor + (0.1 * current_room))).round)
        Cardinal::PLAYER.gain_health(health)
        Cardinal::PLAYER.attack += attack
        Cardinal::PLAYER.defense += defense
        puts "You heal for #{health} points, gain #{attack} attack points, and gain #{defense} defense points!"
      when :uncommon
        health = (5 + (rand(current_floor + (0.1 * current_room))).round)
        attack = (3 + (rand(current_floor + (0.1 * current_room))).round)
        defense = (3 + (rand(current_floor + (0.1 * current_room))).round)
        Cardinal::PLAYER.gain_health(health)
        Cardinal::PLAYER.attack += attack
        Cardinal::PLAYER.defense += defense
        puts "You heal for #{health} points, gain #{attack} attack points, and gain #{defense} defense points!"
      when :rare
        health = (10 + (rand(current_floor + (0.1 * current_room))).round)
        max_health = (5 + (rand(current_floor + (0.1 * current_room))).round)
        attack = (5 + (rand(current_floor + (0.1 * current_room))).round)
        defense = (5 + (rand(current_floor + (0.1 * current_room))).round)
        Cardinal::PLAYER.max_health += max_health
        Cardinal::PLAYER.gain_health(health)
        Cardinal::PLAYER.attack += attack
        Cardinal::PLAYER.defense += defense
        puts "Your max health goes up by #{max_health} points, you heal for #{health} points, gain #{attack} attack points, and gain #{defense} defense points!"
      when :legendary
        max_health = (15 + (rand(current_floor + (0.1 * current_room))).round)
        attack = (10 + (rand(current_floor * 2 + (0.1 * current_room))).round)
        defense = (10 + (rand(current_floor * 2 + (0.1 * current_room))).round)
        Cardinal::PLAYER.max_health += max_health
        Cardinal::PLAYER.health = Cardinal::PLAYER.max_health
        Cardinal::PLAYER.attack += attack
        Cardinal::PLAYER.defense += defense
        puts "Your max health goes up by #{max_health} points, you heal to full, gain #{attack} attack points, and gain #{defense} defense points!"
      end
    end
  end

end

