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

    def self.new(menu, content, options={})
      screen = self.revealControllerWithFrontViewController(nil, leftViewController: nil, options: nil)
      screen.on_create(options) if screen.respond_to?(:on_create)
      screen.menu_controller = menu unless menu.nil?
      screen.content_controller = content unless content.nil?
      screen
    end

    def show_menu
      self.showViewController menu_controller, animated: true, completion: default_completion_block
    end

    def hide_menu
      self.showViewController content_controller, animated: true, completion: default_completion_block
    end

    def menu_controller=(c)
      controller = prepare_controller_for_pm(c)
      controller = controller.main_controller if controller.respond_to?(:main_controller)
      self.setLeftViewController controller, focusAfterChange: true, completion: default_completion_block
    end

    def menu_controller
      self.leftViewController
    end

    def content_controller=(c)
      controller = prepare_controller_for_pm(c)
      controller = controller.main_controller if controller.respond_to?(:main_controller)
      self.setFrontViewController controller, focusAfterChange: true, completion: default_completion_block
    end

    def content_controller
      self.frontViewController
    end


    protected

    def prepare_controller_for_pm(controller)
      controller = setup_screen_for_open(controller, {})
      ensure_wrapper_controller_in_place(controller, {})
      controller
    end

    def default_completion_block
      -> (completed) { true }
    end

  end
end
