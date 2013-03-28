module ProMotionSlideMenu
  class SlideMenuScreen < ProMotion::Screen

    #
    # SlideMenuScreen
    #
    # This is added as the root view controller when using the `open_slide_menu` method in your application delegate.
    # 
    # Several properties are defined to get the underlying PKRevealController instance for additional configuration, the 
    # screen shown as the hidden menu, and the screen shown as the content controller.
    #

    def self.new(menu, content, options={})
      screen = super options
      screen.menu_controller = menu
      screen.content_controller = content
      screen
    end

    def show_menu
      reveal_controller.showViewController menu_controller, animated: true, completion: default_completion_block
    end

    def hide_menu
      reveal_controller.showViewController content_controller, animated: true, completion: default_completion_block
    end

    def reveal_controller
      @reveal_controller ||= PKRevealController.revealControllerWithFrontViewController(nil, leftViewController: nil, options: nil)
    end

    def menu_controller=(c)
      reveal_controller.setLeftViewController prepare_controller_for_pm(c), focusAfterChange: true, completion: default_completion_block
    end

    def menu_controller
      reveal_controller.leftViewController
    end

    def content_controller=(c)
      reveal_controller.setFrontViewController prepare_controller_for_pm(c), focusAfterChange: true, completion: default_completion_block
    end

    def content_controller
      reveal_controller.frontViewController
    end


    protected

    def prepare_controller_for_pm(controller)
      setup_screen_for_open(controller, {})
      ensure_wrapper_controller_in_place(controller, {})
      controller
    end

    def default_completion_block
      -> (completed) { true }
    end

  end
end
