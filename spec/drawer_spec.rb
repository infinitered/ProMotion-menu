describe ProMotion::Menu::Drawer do

  before do
    @delegate = UIApplication.sharedApplication.delegate
    @left = LeftNavScreen.new
    @right = RightNavScreen.new
    @content = BlankScreen.new
  end

  it "returns an instance of PM::Menu::Drawer" do
    menu = ProMotion::Menu::Drawer.new @content, left: @left
    menu.should.be.instance_of ProMotion::Menu::Drawer
  end

  it "stores menu & content controllers" do
    menu = ProMotion::Menu::Drawer.new @content, left: @left
    menu.left_controller.should == @left
    menu.content_controller.should == @content
  end

  it "allows you to pass class instances" do
    menu = ProMotion::Menu::Drawer.new BlankScreen, left: LeftNavScreen
    menu.left_controller.should.be.instance_of LeftNavScreen
    menu.content_controller.should.be.instance_of BlankScreen
  end

  it "presents the menu controller when requested" do
    menu = ProMotion::Menu::Drawer.new @content, left: @left
    menu.show(:left)
    wait(0.5) { menu.openSide.should == MMDrawerSideLeft }
  end

  it "presents the menu controller without animation when requested" do
    menu = ProMotion::Menu::Drawer.new @content, left: @left
    menu.show(:left, false)
    wait(0.1) { menu.openSide.should == MMDrawerSideLeft }
  end

  it "presents the content controller when requested" do
    menu = ProMotion::Menu::Drawer.new @content, left: @left
    menu.hide
    wait(0.5) { menu.openSide.should == MMDrawerSideNone }
  end

  it "lets me wrap the content controller in a UINavigationController" do
    content_controller = BlankScreen.new(nav_bar: true)
    menu = ProMotion::Menu::Drawer.new content_controller, left: @left
    menu.content_controller.should.be.instance_of ProMotion::NavigationController
  end

  it "lets me set the title on the content controller during creation" do
    content_controller = BlankScreen.new(title: 'My Title')
    menu = ProMotion::Menu::Drawer.new content_controller, left: @left
    menu.content_controller.title.should == 'My Title'
  end

  it "accepts a plain UIViewController" do
    menu = ProMotion::Menu::Drawer.new @content, left: @left
    should.not.raise(NoMethodError) { menu.left_controller = UIViewController }
    menu.left_controller.should.be.instance_of UIViewController
  end

  it "allows you to set both a right and left menu controller" do
    menu = ProMotion::Menu::Drawer.new @content, left: @left, right: @right
    menu.left_controller.should == @left
    menu.right_controller.should == @right
    menu.content_controller.should == @content
  end

end
