require 'spec_helper.rb'
# Introduce the concept of a ranged weapon: Grenades!
# Weapons now generally have a default range of 1 but grenades have a range of 2

describe BioBomb do
  before :each do 
    @bio_bomb = BioBomb.new
  end

  it "should be a grenade" do
    expect(@bio_bomb).to be_a Grenade
  end

  it "#name" do
    expect(@bio_bomb.name).to eq("Bio Bomb")
  end

  it "#weight" do
    expect(@bio_bomb.weight).to eq(40)
  end

  it "#damage" do
    expect(@bio_bomb.damage).to eq(30)
  end

  it "#range" do
    expect(@bio_bomb.range).to eq(1)
  end

  it "reduces health of every robot in vicinity by 30 points even if they have shields" do
     robot = Robot.new
     robot2=Robot.new
     robot3=Robot.new
     robot4=Robot.new
     robot4.move_left
     robot.move_up
     robot2.move_right
     robot3.move_up
     robot.pick_up(@bio_bomb)
      expect(robot).to receive(:wound_by_bio_bomb).with(30)
      expect(robot2).to receive(:wound_by_bio_bomb).with(30)
      expect(robot3).to receive(:wound_by_bio_bomb).with(30)
      expect(robot4).to receive(:wound_by_bio_bomb).with(30)
      # This is what will trigger the wound to happen on robot2
      robot.attack_all

     end
end
