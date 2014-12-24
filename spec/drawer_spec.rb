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
    menu.center_controller.should == @content
  end

  it "allows you to pass class instances" do
    menu = ProMotion::Menu::Drawer.new BlankScreen, left: LeftNavScreen
    menu.left_controller.should.be.instance_of LeftNavScreen
    menu.center_controller.should.be.instance_of BlankScreen
  end

  it "lets me wrap the content controller in a UINavigationController" do
    center_controller = BlankScreen.new(nav_bar: true)
    menu = ProMotion::Menu::Drawer.new center_controller, left: @left
    menu.center_controller.should.be.instance_of ProMotion::NavigationController
  end

  it "lets me set the title on the content controller during creation" do
    center_controller = BlankScreen.new(title: 'My Title')
    menu = ProMotion::Menu::Drawer.new center_controller, left: @left
    menu.center_controller.title.should == 'My Title'
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
    menu.center_controller.should == @content
  end

  it "allows you to set whether or not the drawer has a shadow" do
    menu = ProMotion::Menu::Drawer.new @content, left: @left, right: @right, shadow: false
    menu.showsShadow.should == false

    menu.shadow = true
    menu.showsShadow.should == true
  end

  it "doesn't crash if you set the left or right controller to nil" do
    menu = ProMotion::Menu::Drawer.new(@content, left: nil, right: nil)

    menu.left_controller.should == nil
    menu.right_controller.should == nil
    menu.center_controller.should == @content
  end

end
