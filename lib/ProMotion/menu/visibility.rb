module ProMotion; module Menu
  module Visibility

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

    def toggle(side, animated=true)
      toggle_left(animated) if side == :left
      toggle_right(animated) if side == :right
    end

    def toggle_left(animated=true)
      toggleDrawerSide MMDrawerSideLeft, animated: animated, completion: default_completion_block
    end

    def toggle_right(animated=true)
      toggleDrawerSide MMDrawerSideRight, animated: animated, completion: default_completion_block
    end

    def self.included(base)
      base.class_eval do
        alias_method :max_left_width, :maximumLeftDrawerWidth
        alias_method :max_right_width, :maximumRightDrawerWidth

        alias_method :max_left_width=, :setMaximumLeftDrawerWidth
        alias_method :max_right_width=, :setMaximumRightDrawerWidth
      end
    end

  end
end; end
