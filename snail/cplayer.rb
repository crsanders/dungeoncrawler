require_relative 'cardinal.rb'

class Player
  attr_accessor :health
  attr_accessor :attack
  attr_accessor :defense
  attr_accessor :max_health
  attr_accessor :level
  attr_accessor :xp
  attr_accessor :xp_to_level
  attr_accessor :crit_chance

  def initialize
    @level = 1
    @xp = 0
    @xp_to_level = 0
    next_level_requirement
    @max_health = 20
    @health = @max_health
    @attack = 5
    @defense = 5
    @inventory = []
    @crit_chance = 5
  end

  def load_player(max_health,health,attack,defense,level,xp,xp_to_level,crit_chance)
    @max_health = max_health
    @health = health
    @attack = attack
    @defense = defense
    @level = level
    @xp = xp
    @xp_to_level = xp_to_level
    @crit_chance = crit_chance
  end

  def starting_class(class_name)
    if class_name == :fighter
      @max_health = 20
      @health = @max_health
      @attack = 5
      @defense = 5
    elsif class_name == :barbarian
      @max_health = 30
      @health = @max_health
      @attack = 8
      @defense = 3
    elsif class_name == :knight
      @max_health = 25
      @health = @max_health
      @attack = 3
      @defense = 10
    elsif class_name == :thief
      @max_health = 15
      @health = @max_health
      @attack = 3
      @defense = 3
      @crit_chance = 25
    else
      puts "Selecting class error"
    end
  end

  def reset
    @level = 1
    @xp = 0
    @xp_to_level = 0
    next_level_requirement
    @max_health = 20
    @health = @max_health
    @attack = 3
    @defense = 3
    @inventory = []
    @crit_chance = 5
  end

  def next_level_requirement
    @xp_to_level += @level * 10
  end

  def level_up
    puts "You have gained a level!"
    @points = 5
    while @points > 0
      puts "You have #{@points} points to spend!"
      puts "You can spend them on max health, attack, or defense (h,a,d)"
      print "> "; input = gets.chomp
      if input == "health" || input == "h" || input == "Health"
        @max_health += 1
        @health += 1
        puts "Max health increased by 1!"; puts
      elsif input == "attack" || input == "a" || input == "Attack"
        @attack += 1
        puts "Attack increased by 1!"; puts
      elsif input == "defense" || input == "d" || input == "Defense"
        @defense += 1
        puts "Defense increased by 1!"; puts
      else
        puts "Input not recognized."; puts
        @points += 1
      end
      @points -= 1
    end
    @level += 1
    next_level_requirement
    puts "You are now level #{@level}!"; puts
  end

  def current_health
    puts "You currently have #{@health}/#{@max_health}HP"
  end

  def current_attack
    puts "You currently have #{@attack} attack points"
  end

  def current_defense
    puts "You currently have #{@defense} defense points"
  end

  def player_status
    puts "You are currently level #{@level}, with #{@xp}/#{@xp_to_level}XP, #{@health}/#{@max_health}HP, #{@attack} attack points, and #{@defense} defense points"
  end

  def gain_health(amount)
    @health += amount
    if @health > @max_health
      @health = @max_health
    end
  end

  def current_inventory
    puts "You are currently carrying:"
    @inventory.each do |item|
      puts "#{item}"
    end
  end

  def add_to_inventory(item)
    @inventory.push(item)
  end

end

