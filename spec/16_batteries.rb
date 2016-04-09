require_relative 'spec_helper'

describe Battery do
  before :each do
    @battery = Battery.new
      @robot = Robot.new
  end

  it "should be an Item" do
    expect(@battery).to be_a(Item)
  end

  it "should have a weight of 25'" do
    expect(@battery.weight).to eq(25)
  end

  ## if wounded shield battery should heal it to the top

    it "should automatically feed battery if shield  at or below 30hp" do
    allow(@robot).to receive(:shield).and_return(30)
    expect(@battery).to receive(:recharge).and_call_original
    @robot.pick_up(@battery)
  end

end
