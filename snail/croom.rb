require_relative 'cardinal.rb'

class Room
  attr_accessor :mob_array
  attr_accessor :loot

  def initialize
    @loot = 0
    @mobs = 0
    @mob_array = []
    loot_check
    mob_check
  end

  def debug
    @mob_array.each do |mob|
        puts "#{mob}"
    end
  end

  def loot_check
    chance_for_loot = 1 + rand(100)
    case chance_for_loot
    when 1..69
      @loot = 0
    when 70..89
      @loot = 1
    when 90..99
      @loot = 2
    when 100
      @loot = 5
    end
  end

  def mob_check
    chance_for_mobs = 1 + rand(100)
    case chance_for_mobs
    when 1..50
      @mobs = 0
    when 51..80
      @mobs = 1
    when 81..95
      @mobs = 2
    when 96..100
      @mobs = 3
    end
  end

  def remove_mob(target)
    if @mob_array.empty?
      puts "Failed to remove mob, mob array is empty"
    else
      @mob_array.delete_at(target)
      @mobs -= 1 
    end
  end

  def advance_room
    if @mobs == 0
      puts "You advance to the next room!"
      true
    else
      puts "There are still enemies about!  Defeat them to advance!"
      false
    end
  end

  def enter_room
    puts "You enter a new room, discovering #{@loot} pieces of loot"
    puts "and #{@mobs} vicious monsters!"
    target = 0
    while target < @mobs
      if is_rare?(target)
        puts "Monster ##{target + 1} glows with a dark hue."
      end
      target += 1
    end
  end

  def room_status(room_number, floor_number)
    puts "You are currently in room ##{room_number + 1} on floor ##{floor_number}"
    puts "There are currently #{@loot} pieces of loot and"
    puts "#{@mobs} vicious monsters in the room."
    target = 0
    while target < @mobs
      if is_rare?(target)
        puts "Monster ##{target + 1} glows with a dark hue."
      end
      target += 1
    end
  end

  def populate(current_floor, current_room)
    if @mobs != 0
      @mob_array = Array.new(@mobs) { |i| i =  Monster.new(current_floor, current_room) }
    end
  end

  def get_mobs
    @mob_array
  end

  def get_loot(current_floor, current_room)
    while @loot > 0
      Loot.new(current_floor, current_room)
      @loot -= 1
    end
  end

  def is_rare?(target)
    if @mob_array[target].rare_mob
      true
    else
      false
    end
  end

end

