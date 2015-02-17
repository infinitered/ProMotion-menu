describe ProMotion::Menu::Transition do

  before do
    @object = Object.new
    @object.extend(ProMotion::Menu::Transition)

    @delegate = UIApplication.sharedApplication.delegate
    @left = LeftNavScreen.new
    @right = RightNavScreen.new
    @content = BlankScreen.new
  end


  describe "#visualStates" do

    it "returns a visualStateBlock for slideAndScale" do
      @object.mask_for_transition(:slide_and_scale).is_a?(Proc).should == true
    end

    it "returns a visualStateBlock for slide" do
      @object.mask_for_transition(:slide).is_a?(Proc).should == true
    end

    it "returns a visualStateBlock for swingingDoor" do
      @object.mask_for_transition(:slide_and_scale).is_a?(Proc).should == true
    end

    it "returns a visualStateBlock for parallax, when passing in a factor" do
      @object.mask_for_transition(:parallax_5).is_a?(Proc).should == true
    end

    it "returns a visualStateBlock for parallax, default factor" do
      @object.mask_for_transition(:parallax).is_a?(Proc).should == true
    end

  end



end
