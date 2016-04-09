require_relative 'spec_helper.rb'

describe Robot do
  before :each do
    @robot = Robot.new
    @robot2 = Robot.new
    @robot3 = Robot.new
    @robot4 = Robot.new
  end

  describe "#scan_robots" do

      it "should show all robots equal to 4" do
           @robot4.move_left
           @robot.move_up
           @robot2.move_right
       
        expect(@robot.scan_robots.length).to eq(4)  
        
    end
 
end



end




