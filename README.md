# ProMotion SlideMenu
This gem provides an easier way to integrate a great open source toolkit, [RubyMotion](http://www.rubymotion.com), with another great Objective-C framework, [MMDrawerController](https://github.com/mutualmobile/MMDrawerController), allowing you to easily have a cool Facebook or Path style slide navigation menu, complete with gestures.

![Travis CI](https://secure.travis-ci.org/macfanatic/promotion_slide_menu.png?branch=master)

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

### Dependenices
This depends on motion-cocoapods and ProMotion.

### Rakefile

As of [motion-cocoapods](https://github.com/HipByte/motion-cocoapods/compare/1.3.6...1.3.7) v1.3.7, you no longer have to include a pods setup block in your project Rakefile, we can do that for you in the gem.

## Creating and Configuring a Slide Menu
To create a slide menu in your application, you need to start in your AppDelegate:

```ruby
class AppDelegate < PM::Delegate

  def on_load(app, options)

    # Open the slide menu with your content view (initially shown) and navigation view(s) (initially hidden)
    open_slide_menu MyGreatAppScreen.new(nav_bar: true), left: NavigationScreen

    # You can get to the instance of the slide menu at any time if you need to
    slide_menu.controller(:left).class.name
    # => NavigationScreen

    # SlideMenuScreen is just an enhanced subclass of PKRevealController, so you can do all sorts of things with it
    slide_menu.disablesFrontViewInteraction = true
    slide_menu.animationDuration = 0.5
    ...

  end

end
```

## Toggling the Slide Menu Current Screen
To make the slide menu present the menu from anywhere in your app:

```ruby

# Show the menu
App.delegate.slide_menu.show(:left)

# Equivalent to
App.delegate.slide_menu.showViewController App.delegate.slide_menu.left_controller, animated: true, completion: ->(c) { true }

# Hide the menu
App.delegate.slide_menu.hide

# Equivalent to
App.delegate.slide_menu.showViewController App.delegate.slide_menu.content_controller, animated: true, completion: ->(c) { true }

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
    App.delegate.slide_menu.controller(content: screen_class)
  end

end
```

## Showing the menu via gesture
By default, `PKRevealController` supports showing the slide menu via a gesture recognizer.  To disable this feature, look at the documentation or use the following:

```ruby
# Disable the gesture recongizer
App.delegate.slide_menu.removePanGestureRecognizerFromFrontView

# Re-enable the gesture recognizer (enabled by default)
App.delegate.slide_menu.addPanGestureRecognizerToFrontView
```

## Creating a UIBarButtonItem to show the menu
You may want to create a button for users to show the menu in addition to the gesture recognizer.  To do so, in your Screen class:

```ruby
class MyScreen < ProMotion::Screen
  def on_load

    # Create a button with a custom bg & image
    # Example `.custom` method comes from Sugarcube gem: https://github.com/rubymotion/sugarcube#uibutton
    swipe_btn = UIButton.custom
    swipe_btn.setBackgroundImage("nav_bar_menu_show_bg".uiimage, forState: :normal.uicontrolstate)
    swipe_btn.setImage("nav_bar_menu_show".uiimage, forState: :normal.uicontrolstate)
    size = "nav_bar_menu_show_bg".uiimage.size
    swipe_btn.frame = CGRectMake(0, 0, size.width, size.height)

     # Create a Bar button item containing that button
     # When tapping the button, show the menu (uses Sugarcube syntax)
    @left_item = UIBarButtonItem.alloc.initWithCustomView(swipe_btn)
    swipe_btn.on(:touch.uicontrolevent) do
      App.delegate.slide_menu.show(:left)
    end

    # Assign the button item to the navigation item for it to appear in the top left
    self.navigationItem.leftBarButtonItem = @left_item

  end
end
```
