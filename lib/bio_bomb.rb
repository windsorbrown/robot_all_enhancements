class BioBomb < Grenade

  NAME = 'Bio Bomb'
  DAMAGE = 30
  RANGE = 1
  
  attr_reader :range
  
  def initialize
    super
      @range = RANGE
      @name = NAME
      @damage = DAMAGE
  end


end