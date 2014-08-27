module ProMotion
  module Menu
    module Gestures

      SHOW_MASKS = {
        pan_nav_bar: MMOpenDrawerGestureModePanningNavigationBar,  # Pan anywhere on the navigation bar
        pan_content: MMOpenDrawerGestureModePanningCenterView,     # Pan anywhere on the center view
        pan_center: MMOpenDrawerGestureModePanningCenterView,      # Alias of above
        pan_bezel: MMOpenDrawerGestureModeBezelPanningCenterView,  # Pan anywhere within 20 pts of the bezel
        all: MMOpenDrawerGestureModeAll,                           # All of the above
        none: MMOpenDrawerGestureModeNone                          # No gesture recognition
      }

      HIDE_MASKS = {
        pan_nav_bar: MMCloseDrawerGestureModePanningNavigationBar,  # Pan anywhere on the navigation bar
        pan_content: MMCloseDrawerGestureModePanningCenterView,     # Pan anywhere on the center view
        pan_center: MMCloseDrawerGestureModePanningCenterView,      # Alias of above
        pan_bezel: MMCloseDrawerGestureModeBezelPanningCenterView,  # Pan anywhere within the bezel of the center view
        tap_nav_bar: MMCloseDrawerGestureModeTapNavigationBar,      # Tap the navigation bar
        tap_content: MMCloseDrawerGestureModeTapCenterView,         # Tap the center view
        tap_center: MMCloseDrawerGestureModeTapCenterView,          # Alias of above
        pan_menu: MMCloseDrawerGestureModePanningDrawerView,        # Pan anywhere on the drawer view
        all: MMCloseDrawerGestureModeAll,                           # All of the above
        none: MMCloseDrawerGestureModeNone                          # No gesture recognition
      }

      def mask_for_show(gestures)
        mask = 0
        Array(gestures).each do |g|
          mask = mask | SHOW_MASKS[g]
        end
        mask
      end

      def mask_for_hide(gestures)
        mask = 0
        Array(gestures).each do |g|
          mask = mask | HIDE_MASKS[g]
        end
        mask
      end

    end
  end
end
