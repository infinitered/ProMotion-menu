module ProMotionSlideMenu
  module Gestures
    def gesture_type=(type)
      self.openDrawerGestureModeMask = gesture_type_from_symbol type, :open
      self.closeDrawerGestureModeMask = gesture_type_from_symbol type, :close
    end

    def gesture_type
      symbol_from_gesture_type self.openDrawerGestureModeMask
    end

    private

    def gesture_type_from_symbol(symbol, open_or_close)
      type = open_or_close == :open ? "Open" : "Close"

      case symbol
      when :nav
        Object.const_get("MM#{type}DrawerGestureModePanningNavigationBar")
      when :center
        Object.const_get("MM#{type}DrawerGestureModePanningCenterView")
      when :bezel
        Object.const_get("MM#{type}DrawerGestureModeBezelPanningCenterView")
      when :custom
        Object.const_get("MM#{type}DrawerGestureModeCustom")
      when :all
        Object.const_get("MM#{type}DrawerGestureModeAll")
      when :none
        Object.const_get("MM#{type}DrawerGestureModeNone")
      else
        Object.const_get("MM#{type}DrawerGestureModeNone")
      end
    end

    def symbol_from_gesture_type(gesture_type)
      case gesture_type
      when MMOpenDrawerGestureModePanningNavigationBar, MMCloseDrawerGestureModePanningNavigationBar
        :nav
      when MMOpenDrawerGestureModePanningCenterView, MMCloseDrawerGestureModePanningCenterView
        :center
      when MMOpenDrawerGestureModeBezelPanningCenterView, MMCloseDrawerGestureModeBezelPanningCenterView
        :bezel
      when MMOpenDrawerGestureModeCustom, MMCloseDrawerGestureModeCustom
        :custom
      when MMOpenDrawerGestureModeAll, MMCloseDrawerGestureModeAll
        :all
      when MMOpenDrawerGestureModeNone, MMCloseDrawerGestureModeNone
        :none
      end
    end
  end
end
