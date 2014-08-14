module ProMotion
  module Menu
    class Drawer < MMDrawerController
      include ::ProMotion::ScreenModule

      #
      # ProMotion::Menu
      #
      # This is added as the root view controller when using the `open_slide_menu` method in your application delegate.
      #

      def self.new(content, options={})
        left_vc = options.fetch(:left, nil)
        right_vc = options.fetch(:right, nil)

        menu = alloc.init
        menu.content_controller = content unless content.nil?
        menu.left_controller = left_vc if left_vc
        menu.right_controller = right_vc if right_vc

        menu_options = options.reject { |k,v| [:left, :right].include? k }
        menu.on_create(menu_options) if menu.respond_to?(:on_create)
        menu
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
        self.leftDrawerViewController = prepare_controller_for_pm(c)
      end

      def left_controller
        self.leftDrawerViewController
      end

      def right_controller=(c)
        self.rightDrawerViewController = prepare_controller_for_pm(c)
      end

      def right_controller
        self.rightDrawerViewController
      end

      def content_controller=(c)
        self.centerViewController = prepare_controller_for_pm(c)
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
        controller.navigationController || controller
      end

      def default_completion_block
        -> (completed) { true }
      end
    end
  end
end
