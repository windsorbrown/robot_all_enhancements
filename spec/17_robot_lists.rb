require_relative 'spec_helper'

describe Robot do

  describe ".robot_list" do

    it "Empty array to collect robots" do
      expect(Robot.robot_list).to eq([])
    end

    it "Returns a list with 2 robots" do
      @robot = Robot.new
      @robot2 = Robot.new
      expect(Robot.robot_list.length).to eq(2)
    end
    

  end
  

end