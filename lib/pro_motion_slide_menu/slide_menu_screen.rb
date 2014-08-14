module ProMotionSlideMenu
  class SlideMenuScreen < MMDrawerController

    include ::ProMotion::ScreenModule

    #
    # SlideMenuScreen
    #
    # This is added as the root view controller when using the `open_slide_menu` method in your application delegate.
    #

    def self.new(content, options={})
      left_vc = options.fetch(:left, nil)
      right_vc = options.fetch(:right, nil)

      screen = alloc.init
      screen.content_controller = content unless content.nil?
      screen.left_controller = left_vc if left_vc
      screen.right_controller = right_vc if right_vc

      screen_options = options.reject { |k,v| [:left, :right].include? k }
      screen.on_create(screen_options) if screen.respond_to?(:on_create)
      screen
    end

    def show(side, animated=true)
      self.show_left(animated) if side == :left
      self.show_right(animated) if side == :right
    end

    def show_left(animated = true)
      openDrawerSide MMDrawerSideLeft, animated: animated, completion: default_completion_block
    end

    def show_right(animated = true)
      openDrawerSide MMDrawerSideRight, animated: animated, completion: default_completion_block
    end

    def hide(animated = true)
      closeDrawerAnimated animated, completion: default_completion_block
    end

    def left_controller=(c)
      controller = prepare_controller_for_pm(c)
      controller = controller.navigationController || controller
      self.leftDrawerViewController = controller
    end

    def left_controller
      self.leftDrawerViewController
    end

    def right_controller=(c)
      controller = prepare_controller_for_pm(c)
      controller = controller.navigationController || controller
      self.rightDrawerViewController = controller
    end

    def right_controller
      self.rightDrawerViewController
    end

    def content_controller=(c)
      controller = prepare_controller_for_pm(c)
      controller = controller.navigationController || controller
      self.centerViewController = controller
    end

    def content_controller
      self.centerViewController
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
