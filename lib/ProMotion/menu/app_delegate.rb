module ProMotion
  module AppDelegate

    def self.included(base)
      base.send :attr_accessor, :slide_menu
    end

    def has_slide_menu?
      !slide_menu.nil?
    end

    def open_slide_menu(content, options={})
      self.slide_menu = ProMotion::Menu::Drawer.new(content, options)
      open_root_screen slide_menu
      slide_menu
    end

  end
end

PM::Delegate.send :include, ProMotion::AppDelegate
