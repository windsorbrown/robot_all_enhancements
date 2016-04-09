class Robot

  MAX_WEIGHT = 250
  MAX_HEALTH = 100
  MIN_HEALTH = 0
  DEFAULT_ATTACK = 5

  class RobotAlreadyDeadError < StandardError; end
  class UnattackableEnemy < StandardError; end

  @@robot_list = []

  attr_reader :position , :items, :items_weight, :health ,:shield
  attr_accessor :equipped_weapon 
  
  def initialize
    @position = [0,0]
    @items = []
    @items_weight = 0
    @health = 100
    @equipped_weapon = nil
    @shield = 50
    @@robot_list << self
  end

#moves robot left
  def move_left
    @position[0] -= 1
  end

#moves robot right
  def move_right
    @position[0] +=1
  end

#moves robot up
  def move_up
    @position[1] +=1
  end

#moves robot down
  def move_down
    @position[1] -=1
  end

# if item is a weapon its equips the weapon
# if box of bolts then heals only if health under 80
# if battery then heals shield only if shield under 30
# otherwise adds to the item bag and makes sure its under maximum weight
  def pick_up(item)
        if   (item.is_a?Weapon)
          self.equipped_weapon = item
        else
          self.equipped_weapon =nil  
          if item.is_a?(BoxOfBolts) && health <= 80 
              self.equipped_weapon =nil  
              item.feed(self)
          elsif item.is_a?(Battery) && shield <= 30
              item.recharge(self)
          elsif items_weight + item.weight <= MAX_WEIGHT
              @items << item
              @items_weight += item.weight
      end
    end
  end

# scans 1 block around of itself to see enemies (including itself)
    def scan_robots
      scanned_bots = []
      Robot.robot_list.each do |other_robot|
      if  (self.position[0] - other_robot.position[0]).abs && (self.position[1] - other_robot.position[1]).abs <= 1
          scanned_bots << other_robot
       end
      end
      scanned_bots
    end

# when attacked reduces shield first and then health. if under 0 then just stays at 0 (dead)
  def wound (attack_points)
    if shield - attack_points <= MIN_HEALTH
      leftover_attack_points = attack_points - shield
      @shield =0
       health - (leftover_attack_points) <= MIN_HEALTH ?  @health = 0  : @health -= (leftover_attack_points) 
     else
      @shield -= attack_points
     end
  end 
#when wounded by biobomb. goes over the shield
  def wound_by_bio_bomb(attack_points)
    health  <= MIN_HEALTH ?  @health = 0  : @health -= attack_points     
  end

#heals robot
  def heal(heal_points)
      health + heal_points >= MAX_HEALTH ?  @health = 100 : @health += heal_points
  end

#heals shield
  def heal_shield
      @shield = 50
  end

#cannot heal if dead
 def heal!(heal_points)
    unless health == 0
     health + heal_points >= MAX_HEALTH ?  @health = 100 : @health += heal_points
    end
    raise RobotAlreadyDeadError, "Robot is Already dead"
  end

#can only attack if range
  def attack(other_robot)
    if (equipped_weapon.is_a?BioBomb)
      attack_all
    else
      if enemy_range(other_robot, equipped_weapon)
        equipped_weapon.nil? ? other_robot.wound(DEFAULT_ATTACK) : equipped_weapon.hit(other_robot)
        self.equipped_weapon = nil if (equipped_weapon.is_a?Grenade)
      end
    end
  end

  #attacks everyone in vicinity including itself. with the special biobomb
  def attack_all
      scan_robots.each do |robot|
        equipped_weapon.hit_special(robot)
      end
      self.equipped_weapon = nil
  end

#cannot attack if dead
  def attack!(other_robot)
    if(other_robot.is_a?Robot)
     equipped_weapon.nil? ? other_robot.wound(DEFAULT_ATTACK) : equipped_weapon.hit(other_robot)
    end
    raise UnattackableEnemy, "Robot is Already dead"
  end

#check range of enemy
  def enemy_range(other_robot, weapon)
    (weapon.is_a?Grenade) ? range = 2 : range = 1
    return true  if  (self.position[0] - other_robot.position[0]).abs && (self.position[1] - other_robot.position[1]).abs <= range
  end

  class << self

# robot list reader
    def robot_list
      @@robot_list
    end

# check robots at any given position
    def in_position(x,y)
       robots_in_position = 0
        Robot.robot_list.each do |robot|
         if robot.position == [x,y]
            robots_in_position +=1
          end
        end
        robots_in_position
      end


  end

end

