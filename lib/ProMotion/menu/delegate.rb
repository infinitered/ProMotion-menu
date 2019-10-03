module ProMotion
  module Menu
    module Delegate

      def menu=(m)
        @menu = m
      end
      alias_method :slide_menu=, :menu=

      def menu
        @menu
      end
      alias_method :slide_menu, :menu

      def has_menu?
        !menu.nil?
      end
      alias_method :has_slide_menu?, :has_menu?

      def open_menu(content, options={})
        self.menu = ProMotion::Menu::Drawer.new(options.merge(center: content))
        open_root_screen menu
        menu
      end
      alias_method :open_slide_menu, :open_menu # backwards compat

    end
  end
end

PM::Delegate.send :include, ProMotion::Menu::Delegate
