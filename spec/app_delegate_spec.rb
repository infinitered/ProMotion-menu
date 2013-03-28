describe ProMotionSlideMenu::AppDelegate do

  before do
    @delegate = App.delegate
  end

  it "should have a 'slide_menu' attribute" do
    @delegate.respond_to?(:slide_menu).should == true
  end

  it "should not have a slide menu by default" do
    @delegate.has_slide_menu?.should == false
  end

  it "should respond to 'open_slide_menu'" do
    @delegate.respond_to?(:open_slide_menu).should == true
  end

  it "#open_slide_menu should return a SlideMenuScreen" do
    @delegate.open_slide_menu(nil, nil).should.be.instance_of ProMotionSlideMenu::SlideMenuScreen
  end 

end
