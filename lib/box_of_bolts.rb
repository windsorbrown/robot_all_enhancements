class BoxOfBolts < Item

  HEAL_POINTS = 20
  NAME = "Box of bolts"
  WEIGHT = 25

  def initialize
    super(NAME , WEIGHT)

  end

  def feed(robot)
    robot.heal(HEAL_POINTS)
  end

end