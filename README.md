# ProMotion SlideMenu
This gem provides an easier way to integrate a great open source toolkit, [RubyMotion](http://www.rubymotion.com), with another great Objective-C framework, [PKRevealController](https://github.com/pkluz/PKRevealController), allowing you to easily have a cool facebook or Path style slide navigation menu from the left or right, complete with gestures.

## Installation

### Bundler

Add the following to your project's `Gemfile` to work with bundler.

```ruby
gem "pro_motion_slide_menu"
```

Install with bundler:

```ruby
bundle install
```

### Rakefile

Currently there is a bug with [motion-cocoapods](https://github.com/HipByte/motion-cocoapods/issues/38) that doesn't allow us to automatically include an ObjC library automatically.  Because of this, you will need to edit your Rakefile as follows:

```ruby
app.pods do
  pod 'PKRevealController'
end
```

## Creating and Configuring a Slide Menu
To create a slide menu in your application, you need to start in your AppDelegate:

```ruby
class AppDelegate < ProMotion::AppDelegateParent
  
  def on_load(app, options)

    # Open the slide menu with your navigation view (initially hidden) and a content view (initially shown)
    open_slide_menu NavigationScreen, MyGreatAppScreen.new(nav_bar: true)

    # You can get to the instance of the slide menu at any time if you need to
    slide_menu.menu_controller.class.name
    # => NavigationScreen

    # Since you can get to the menu, you can also get to the underlying PKRevealController to make customizations there if needed
    slide_menu.reveal_controller

  end

end
```

## Toggling the Slide Menu Current Screen
To make the slide menu present the menu from anywhere in your app:

```ruby

# Show the menu
App.delegate.slide_menu.show_menu

# Hide the menu
App.delegate.slide_menu.hide_menu

```

## Setting up the Menu
You can use any `UIViewController` subclass you want as the menu controller, but the easiest way to provide this would be to subclass `ProMotion::TableScreen` like below:

```ruby
class NavigationScreen < ProMotion::TableScreen

  def table_data
    [{
      title: nil,
      cells: [{
        title: 'OVERWRITE THIS METHOD',
        action: :swap_content_controller,
        arguments: HomeScreen
      }]
    }]
  end

  def swap_content_controller(screen_class)
    App.delegate.swipe_menu.content_controller = screen_class
  end

end
```

## Showing the menu via gesture
By default, `PKRevealController` supports showing the slide menu via a gesture recognizer.  To disable this feature, look at the documentation or use the following:

```ruby
App.delegate.swipe_menu.reveal_controller.recognizesPanningOnFrontView = false
```

## Creating a UIBarButtonItem to show the menu
You may want to create a button for users to show the menu in addition to the gesture recognizer.  To do so, in your Screen class:

```ruby
class MyScreen < ProMotion::Screen
  def on_load

    # Create a button with a custom bg & image
    swipe_btn = UIButton.custom
    swipe_btn.setBackgroundImage("nav_bar_menu_show_bg".uiimage, forState: :normal.uicontrolstate)
    swipe_btn.setImage("nav_bar_menu_show".uiimage, forState: :normal.uicontrolstate)
    size = "nav_bar_menu_show_bg".uiimage.size
    swipe_btn.frame = CGRectMake(0, 0, size.width, size.height)

     # Create a Bar button item containing that button
     # When tapping the button, show the menu (uses Sugarcube syntax)
    @left_item = UIBarButtonItem.alloc.initWithCustomView(swipe_btn)    
    swipe_btn.on(:touch.uicontrolevent) do
      App.delegate.slide_menu.show_menu
    end

    # Assign the button item to the navigation item for it to appear in the top left
    self.navigationItem.leftBarButtonItem = @left_item
    
  end
end
```
