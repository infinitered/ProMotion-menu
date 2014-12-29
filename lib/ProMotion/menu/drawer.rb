module ProMotion
  module Menu
    class Drawer < MMDrawerController
      include ::ProMotion::ScreenModule
      include Gestures
      include Visibility

      def self.new(center=nil, options={})
        menu = alloc.init
        menu.send(:auto_setup, center, options)
        menu
      end

      def auto_setup(center, options={})
        options[:to_show] ||= :pan_bezel
        options[:to_hide] ||= [:pan_center, :tap_center]
        options[:center] ||= center if center
        shadow = options[:shadow] unless options[:shadow].nil?
        set_attributes self, options
        self.send(:setup) if self.respond_to?(:setup)
      end

      def left_controller=(c)
        self.leftDrawerViewController = prepare_controller_for_pm(c)
      end
      alias_method :left=, :left_controller=

      def left_controller
        self.leftDrawerViewController
      end
      alias_method :left, :left_controller

      def right_controller=(c)
        self.rightDrawerViewController = prepare_controller_for_pm(c)
      end
      alias_method :right=, :right_controller=

      def right_controller
        self.rightDrawerViewController
      end
      alias_method :right, :right_controller

      def center_controller=(c)
        self.centerViewController = prepare_controller_for_pm(c)
      end
      alias_method :content_controller=, :center_controller=
      alias_method :center=, :center_controller=
      alias_method :content=, :center_controller=

      def center_controller
        self.centerViewController
      end
      alias_method :content_controller, :center_controller
      alias_method :center, :center_controller
      alias_method :content, :center_controller

      def controller=(side={})
        self.left_controller = side[:left] if side[:left]
        self.right_controller = side[:right] if side[:right]
        self.center_controller = side[:center] if side[:center]
        self.center_controller ||= side[:content] if side[:content]
      end
      alias_method :controllers=, :controller=

      def controller(side)
        return self.left_controller if side == :left
        return self.right_controller if side == :right
        self.center_controller if [:content, :center].include?(side)
      end

      def shadow=(show_shadow)
        self.setShowsShadow(show_shadow)
      end

    protected

      def prepare_controller_for_pm(controller)
        unless controller.nil?
          controller = set_up_screen_for_open(controller, {})
          ensure_wrapper_controller_in_place(controller, {})
          controller.navigationController || controller
        end
      end

      def default_completion_block
        -> (completed) { true }
      end

    end
  end
end
