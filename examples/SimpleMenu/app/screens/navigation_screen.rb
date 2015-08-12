class NavigationScreen < ProMotion::TableScreen

  def table_data
    [{
      title: nil,
      cells: [{
        title: 'Home',
        action: :swap_center_controller,
        arguments: HomeScreen
      }]
    }]
  end

  def swap_center_controller(screen_class)
    # Just use screen_class if you don't need a navigation bar
    app_delegate.menu.center_controller = screen_class.new(nav_bar: true)
    app_delegate.menu.toggle_left
  end

end