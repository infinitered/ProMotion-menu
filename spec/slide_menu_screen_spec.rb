describe ProMotionSlideMenu::SlideMenuScreen do

  before do
    @delegate = UIApplication.sharedApplication.delegate
    @left = LeftNavScreen.new
    @right = RightNavScreen.new
    @content = BlankScreen.new
  end

  it "should return an instance of SlideMenuScreen" do
    screen = ProMotionSlideMenu::SlideMenuScreen.new nil, left: nil
    screen.should.be.instance_of ProMotionSlideMenu::SlideMenuScreen
  end

  it "should store menu & content controllers" do
    screen = ProMotionSlideMenu::SlideMenuScreen.new @content, left: @left
    screen.left_controller.should == @left
    screen.content_controller.should == @content
  end

  it "should allow you to pass class instances" do
    screen = ProMotionSlideMenu::SlideMenuScreen.new BlankScreen, left: LeftNavScreen
    screen.left_controller.should.be.instance_of LeftNavScreen
    screen.content_controller.should.be.instance_of BlankScreen
  end

  it "should present the menu controller when requested" do
    screen = ProMotionSlideMenu::SlideMenuScreen.new @content, left: @left
    screen.show(:left)
    wait(0.5) { screen.focusedController.should == @left }
  end

  it "should present the menu controller without animation when requested" do
    screen = ProMotionSlideMenu::SlideMenuScreen.new @content, left: @left
    screen.show(:left, false)
    wait(0.1) { screen.focusedController.should == @left }
  end

  it "should present the content controller when requested" do
    screen = ProMotionSlideMenu::SlideMenuScreen.new @content, left: @left
    screen.hide
    wait(0.5) { screen.focusedController.should == @content }
  end

  it "should let me wrap the content controller in a UINavigationController" do
    content_controller = BlankScreen.new(nav_bar: true)
    screen = ProMotionSlideMenu::SlideMenuScreen.new content_controller, left: @left
    screen.content_controller.should.be.instance_of ProMotion::NavigationController
  end

  it "should let me set the title on the content controller during creation" do
    content_controller = BlankScreen.new(title: 'My Title')
    screen = ProMotionSlideMenu::SlideMenuScreen.new content_controller, left: @left
    screen.content_controller.title.should == 'My Title'
  end

  it "should accept a plain UIViewController" do
    screen = ProMotionSlideMenu::SlideMenuScreen.new nil, left: nil
    should.not.raise(NoMethodError) { screen.left_controller = UIViewController }
    screen.left_controller.should.be.instance_of UIViewController
  end

  it "should allow you to set both a right and left menu controller" do
    screen = ProMotionSlideMenu::SlideMenuScreen.new @content, left: @left, right: @right
    screen.left_controller.should == @left
    screen.right_controller.should == @right
    screen.content_controller.should == @content
  end

end
