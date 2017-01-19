require_relative 'cardinal.rb'

class FloorHandler
  attr_accessor :floor_num
  attr_accessor :rooms
  @@floor = 0

  def initialize
    @@floor += 1
    @floor_num = @@floor
    @attack_handler = nil
    puts "You are currently on floor #{@@floor}."
    num_rooms = draw_floor(@@floor)
    @rooms = Array.new(num_rooms) { |i| i = Room.new }
    @rooms.push(ExitRoom.new(@@floor))
    current_room = 0
    while current_room < num_rooms
#      puts "Populating room ##{current_room}"
      @rooms[current_room].populate(@@floor, current_room + 1)
      current_room += 1
    end
#    @rooms.each do |room|
#      puts "#{room}"
#    end
  end

  def load_floor_number(floor)
    @@floor = floor
  end

  def self.reset
    @@floor = 0
  end

  def draw_floor(floor_number)
    num_possible_rooms = floor_number ** 2
    num_rooms = 1 + rand(num_possible_rooms)
  end

  def play_room(current_room, status)
    if status == :enter
      if @rooms[current_room] == @rooms[-1]
        @rooms[current_room].announce
      else
        @rooms[current_room].enter_room
      end
    elsif status == :advance
      if @rooms[current_room] == @rooms[-1]
        @rooms[current_room].advance_floor
        current_room
      elsif @rooms[current_room].advance_room
        current_room += 1
      else
        current_room
      end
    elsif status == :attack
      @attack_handler = Attack.new
      if @rooms[current_room] == @rooms[-1]
#        puts "Still working on boss fights"
      else
        @attack_handler.choose_target(@rooms[current_room].mob_array)
        if @attack_handler.check_deaths
          target = @attack_handler.target
          if @rooms[current_room].is_rare?(target)
            puts "Monster ##{target + 1} drops a piece of loot!"
            @rooms[current_room].loot += 1
          else
            chance = 1 + rand(100)
            if chance > 89
              puts "Monster ##{target + 1} drops a piece of loot!"
              @rooms[current_room].loot += 1
            end
          end
          @rooms[current_room].remove_mob(target)
        end
        if !@rooms[current_room].mob_array.empty?
          target = 0
          while target < @rooms[current_room].mob_array.size
            @attack_handler.attack_target(target, :mob)
            target += 1
          end
        end
      end
    elsif status == :loot
      if @rooms[current_room].loot == 0
        puts "Nothing to loot!"
      else
        @rooms[current_room].get_loot(@@floor, current_room)
      end
    elsif status == :room_status
      if @rooms[current_room] == @rooms[-1]
        @rooms[current_room].announce
      else
        @rooms[current_room].room_status(current_room, @@floor)
      end
    elsif status == :debug
      puts "#{@rooms[current_room].debug}"
    end
  end

end

