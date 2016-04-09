require_relative 'spec_helper.rb'

describe Robot do
  before :each do
    @robot = Robot.new
    @robot2 = Robot.new
    @robot3 = Robot.new
    @robot4 = Robot.new
  end

  describe ".Robot.in_position" do
      it "should show 2 robots on [1,0]" do
        @robot.move_left
        @robot2.move_right
        @robot3.move_right
        @robot4.move_up
        expect(Robot.in_position(1,0)).to eq(2)  
      
    end
  
      it "should show 1 robot on [-1,0]" do
        
        expect(Robot.in_position(-1,0)).to eq(1)  

  end

end



end




