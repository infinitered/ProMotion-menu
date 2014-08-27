describe ProMotion::Menu::Delegate do

  before do
    @delegate = UIApplication.sharedApplication.delegate
  end

  it "should have a 'slide_menu' attribute" do
    @delegate.respond_to?(:slide_menu).should == true
  end

  it "should not have a slide menu by default" do
    @delegate.has_menu?.should == false
  end

  it "should respond to 'open_menu'" do
    @delegate.respond_to?(:open_menu).should == true
  end

  it "#open_menu should return a Menu::Drawer" do
    @delegate.open_menu(BlankScreen, left: LeftNavScreen).should.be.instance_of ProMotion::Menu::Drawer
  end

  it "should have a Menu::Drawer as the rootViewController" do
    @delegate.open_menu(BlankScreen)

    @delegate.window.rootViewController.should.be.instance_of ProMotion::Menu::Drawer
  end

end
