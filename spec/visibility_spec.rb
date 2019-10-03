describe ProMotion::Menu::Visibility do

  before do
    @delegate = UIApplication.sharedApplication.delegate
    @left = LeftNavScreen.new
    @right = RightNavScreen.new
    @content = BlankScreen.new
  end

  describe "#show" do
    it "presents the menu controller when requested" do
      menu = ProMotion::Menu::Drawer.new center: @content, left: @left
      menu.show(:left)
      wait(0.5) { menu.openSide.should == MMDrawerSideLeft }
    end

    it "presents the menu controller without animation when requested" do
      menu = ProMotion::Menu::Drawer.new center: @content, left: @left
      menu.show(:left, false)
      wait(0.1) { menu.openSide.should == MMDrawerSideLeft }
    end
  end

  describe "#hide" do
    it "presents the content controller when requested" do
      menu = ProMotion::Menu::Drawer.new center: @content, left: @left
      menu.hide
      wait(0.5) { menu.openSide.should == MMDrawerSideNone }
    end
  end

  describe "#toggle" do
    before do
      @menu = ProMotion::Menu::Drawer.new center: @content, left: @left, right: @right
    end

    describe "from left" do
      it "opens the menu " do
        @menu.toggle(:left)
        wait 0.25 do
          @menu.openSide.should == MMDrawerSideLeft
        end
      end

      it "closes the menu" do
        @menu.show(:left)
        wait 0.25 do

          @menu.openSide.should == MMDrawerSideLeft
          @menu.toggle(:left)

          wait 0.25 do
            @menu.openSide.should == MMDrawerSideNone
          end
        end
      end
    end

    describe "from right" do
      it "opens the menu" do
        @menu.toggle(:right)
        wait 0.25 do
          @menu.openSide.should == MMDrawerSideRight
        end
      end

      it "closes the menu" do
        @menu.show(:right)
        wait 0.25 do

          @menu.openSide.should == MMDrawerSideRight
          @menu.toggle(:right)

          wait 0.25 do
            @menu.openSide.should == MMDrawerSideNone
          end
        end
      end
    end
  end

  describe "#max_left_width" do
    before do
      @menu = ProMotion::Menu::Drawer.new center: @content, left: @left, right: @right
    end

    it "returns the maximum width for a given drawer" do
      @menu.max_left_width.should.be.kind_of? Float
    end
  end

  describe "#max_left_width=" do
    before do
      @menu = ProMotion::Menu::Drawer.new center: @content, left: @left, right: @right
    end

    it "sets a maximum drawer width" do
      @menu.max_left_width = 250
      @menu.maximumLeftDrawerWidth.should == 250
    end
  end

end
