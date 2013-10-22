module ProMotionSlideMenu
  class SlideMenuScreen < PKRevealController

    include ::ProMotion::ScreenModule

    #
    # SlideMenuScreen
    #
    # This is added as the root view controller when using the `open_slide_menu` method in your application delegate.
    #
    # Several properties are defined to get the underlying PKRevealController instance for additional configuration, the
    # screen shown as the hidden menu, and the screen shown as the content controller.
    #

    def self.new(content, options={})
      screen = self.revealControllerWithFrontViewController(nil, leftViewController: nil, options: nil)
      screen.content_controller = content unless content.nil?
      screen.left_controller = options[:left] if options[:left]
      screen.right_controller = options[:right] if options[:right]
      screen_options = options.reject { |k,v| [:left, :right].include? k }
      screen.on_create(screen_options) if screen.respond_to?(:on_create)
      screen
    end

    def show(side)
      self.show_left if side == :left
      self.show_right if side == :right
    end

    def show_left
      self.showViewController left_controller, animated: true, completion: default_completion_block
    end

    def show_right
      self.showViewController right_controller, animated: true, completion: default_completion_block
    end

    def hide
      self.showViewController content_controller, animated: true, completion: default_completion_block
    end

    def left_controller=(c)
      controller = prepare_controller_for_pm(c)
      controller = controller.navigationController || controller
      self.setLeftViewController controller, focusAfterChange: true, completion: default_completion_block
    end

    def left_controller
      self.leftViewController
    end

    def right_controller=(c)
      controller = prepare_controller_for_pm(c)
      controller = controller.navigationController || controller
      self.setRightViewController controller, focusAfterChange: true, completion: default_completion_block
    end

    def right_controller
      self.rightViewController
    end

    def content_controller=(c)
      controller = prepare_controller_for_pm(c)
      controller = controller.navigationController || controller
      self.setFrontViewController controller, focusAfterChange: true, completion: default_completion_block
    end

    def content_controller
      self.frontViewController
    end

    def controller=(side={})
      self.left_controller = side[:left] if side[:left]
      self.right_controller = side[:right] if side[:right]
      self.content_controller = side[:content] if side[:content]
    end

    alias_method :controllers=, :controller=

    def controller(side)
      self.left_controller if side == :left
      self.right_controller if side == :right
      self.content_controller if side == :content
    end

    protected

    def prepare_controller_for_pm(controller)
      controller = set_up_screen_for_open(controller, {})
      ensure_wrapper_controller_in_place(controller, {})
      controller
    end

    def default_completion_block
      -> (completed) { true }
    end

  end
end
