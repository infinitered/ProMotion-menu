class HomeScreen < PM::Screen
  title "Home"

  def on_load
    set_nav_bar_button :left, title: "Menu", action: :nav_left_button
  end

  def nav_left_button
    # toggle left will allow the nav button to open and close the menu
    app_delegate.menu.toggle_left
  end

end