class Weapon < Item

  #DAMAGE_POINTS = 45
  attr_reader :damage


  def initialize(name, weight, damage)
    super(name, weight )
    @damage = damage
  end

  def hit(robot)
    robot.wound(damage)
  end

  def hit_special(robot)
    robot.wound_by_bio_bomb(damage)
  end
end