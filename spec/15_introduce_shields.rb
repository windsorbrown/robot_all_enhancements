require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe "#shield" do
    it "should be 50" do
      expect(@robot.shield).to eq(50)
    end
  end

    describe "#wound" do
    it "decreases shield first" do
      @robot.wound(20)
      expect(@robot.shield).to eq(30)
    end

    it "deletes the shield and effects health with the left over" do
      @robot.wound(125)
      expect(@robot.shield).to eq(0)
      expect(@robot.health).to eq(25)
    end
  end


end
