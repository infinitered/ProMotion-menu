class AppDelegate < PM::Delegate
  def on_load(app, options)
    open_menu HomeScreen.new(nav_bar: true), left: NavigationScreen, to_show: :pan_nav_bar, to_hide: [:pan_nav_bar, :tap_nav_bar, :tap_center]
  end
end