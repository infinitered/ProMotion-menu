describe ProMotionSlideMenu::SlideMenuScreen do

  before do
    @delegate = App.delegate
    @menu = LeftNavScreen.new
    @content = BlankScreen.new
  end

  it "should return an instance of SlideMenuScreen" do
    screen = ProMotionSlideMenu::SlideMenuScreen.new nil, nil
    screen.should.be.instance_of ProMotionSlideMenu::SlideMenuScreen
  end

  it "should store menu & content controllers" do
    screen = ProMotionSlideMenu::SlideMenuScreen.new @menu, @content
    screen.menu_controller.should == @menu
    screen.content_controller.should == @content
  end

  it "should present the menu controller when requested" do
    screen = ProMotionSlideMenu::SlideMenuScreen.new @menu, @content
    screen.show_menu
    wait(0.5) { screen.reveal_controller.focusedController.should == @menu }
  end

  it "should present the content controller when requested" do
    screen = ProMotionSlideMenu::SlideMenuScreen.new @menu, @content
    screen.hide_menu
    wait(0.5) { screen.reveal_controller.focusedController.should == @content }
  end

  it "should let me wrap the content controller in a UINavigationController" do
    content_controller = BlankScreen.new(nav_bar: true)
    screen = ProMotionSlideMenu::SlideMenuScreen.new @menu, content_controller
    screen.content_controller.main_controller.should.be.instance_of ProMotion::NavigationController
  end

  it "should let me set the title on the content controller during creation" do
    content_controller = BlankScreen.new(title: 'My Title')
    screen = ProMotionSlideMenu::SlideMenuScreen.new @menu, content_controller
    screen.content_controller.title.should == 'My Title'
  end

end
