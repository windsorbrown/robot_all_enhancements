class Grenade < Weapon

  NAME = 'Grenade'
  WEIGHT = 40
  DAMAGE = 15
  RANGE = 2
  
  attr_reader :range
  
  def initialize
    super(NAME,WEIGHT, DAMAGE)
    @range = RANGE
  
  end

end