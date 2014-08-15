module ProMotion
  module Menu
    class Drawer < MMDrawerController
      include ::ProMotion::ScreenModule
      include ::ProMotion::Menu::Gestures

      def self.new(center, options={})
        left_vc = options.fetch(:left, nil)
        right_vc = options.fetch(:right, nil)
        open_with = options.fetch(:open_with, nil)
        close_with = options.fetch(:close_with, nil)

        menu = alloc.init
        menu.center_controller = center unless center.nil?
        menu.left_controller = left_vc if left_vc
        menu.right_controller = right_vc if right_vc
        menu.open_gestures = open_with if open_with
        menu.close_gestures = close_with if close_with

        menu_options = options.reject { |k,v| [:left, :right, :open_with, :close_with].include? k }
        menu.on_create(menu_options) if menu.respond_to?(:on_create)
        menu
      end

      def show(side, animated=true)
        self.show_left(animated) if side == :left
        self.show_right(animated) if side == :right
      end

      def show_left(animated=true)
        openDrawerSide MMDrawerSideLeft, animated: animated, completion: default_completion_block
      end

      def show_right(animated=true)
        openDrawerSide MMDrawerSideRight, animated: animated, completion: default_completion_block
      end

      def hide(animated=true)
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

      def center_controller=(c)
        self.centerViewController = prepare_controller_for_pm(c)
      end
      alias_method :content_controller=, :center_controller=

      def center_controller
        self.centerViewController
      end
      alias_method :content_controller, :center_controller

      def controller=(side={})
        self.left_controller = side[:left] if side[:left]
        self.right_controller = side[:right] if side[:right]
        self.center_controller = side[:center] if side[:center]
        self.center_controller ||= side[:content] if side[:content]
      end

      alias_method :controllers=, :controller=

      def controller(side)
        self.left_controller if side == :left
        self.right_controller if side == :right
        self.center_controller if side == :content || side == :center
      end

      def open_gestures=(gestures)
        self.openDrawerGestureModeMask = mask_for_open(gestures)
      end

      def close_gestures=(gestures)
        self.closeDrawerGestureModeMask = mask_for_close(gestures)
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
