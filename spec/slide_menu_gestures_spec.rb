describe ProMotionSlideMenu::Gestures do

  before do
    @delegate = UIApplication.sharedApplication.delegate
    @screen = ProMotionSlideMenu::SlideMenuScreen.new BlankScreen, left: LeftNavScreen
  end

  it "defaults to MMOpenDrawerGestureModePanningNavigationBar" do
    @screen.openDrawerGestureModeMask.should == MMOpenDrawerGestureModePanningNavigationBar
  end

  describe "#gesture_type=" do
    before do
      @screen.gesture_type = :custom
    end

    it "sets the left mask" do
      @screen.openDrawerGestureModeMask.should == MMOpenDrawerGestureModeCustom
    end

    it "sets the right mask" do
      @screen.closeDrawerGestureModeMask.should == MMCloseDrawerGestureModeCustom
    end
  end

  describe "#gesture_type" do
    it "returns symbol for open" do
      @screen.openDrawerGestureModeMask = MMCloseDrawerGestureModeCustom
      @screen.gesture_type.should == :custom
    end
  end
end
