# ProMotion-menu [![Gem Version](https://badge.fury.io/rb/ProMotion-menu.png)](http://badge.fury.io/rb/ProMotion-menu) [![Build Status](https://travis-ci.org/clearsightstudio/ProMotion-menu.svg?branch=master)](https://travis-ci.org/clearsightstudio/ProMotion-menu) [![Code Climate](https://codeclimate.com/github/clearsightstudio/ProMotion-menu/badges/gpa.svg)](https://codeclimate.com/github/clearsightstudio/ProMotion-menu) [![Test Coverage](https://codeclimate.com/github/clearsightstudio/ProMotion-menu/badges/coverage.svg)](https://codeclimate.com/github/clearsightstudio/ProMotion-menu)

![sample app](https://camo.githubusercontent.com/171bc22d1f4ad13f7be22cf546c2644176066193/687474703a2f2f6d757475616c6d6f62696c652e6769746875622e696f2f4d4d447261776572436f6e74726f6c6c65722f4578616d706c65496d616765732f6578616d706c65312e706e67) ![sample app open](https://camo.githubusercontent.com/5c4050ef64d7b9836b6a56b89b458ed5c8fdfb7f/687474703a2f2f6d757475616c6d6f62696c652e6769746875622e696f2f4d4d447261776572436f6e74726f6c6c65722f4578616d706c65496d616765732f6578616d706c65322e706e67)

ProMotion-menu provides a menu component for the popular RubyMotion gem [ProMotion](https://github.com/clearsightstudio/ProMotion). Utilizing [MMDrawerController](https://github.com/mutualmobile/MMDrawerController) it allows you to easily have a cool Facebook or Path style slide navigation menu, complete with gestures.

The gem was originally named `pro_motion_slide_menu` and authored by [Matt Brewer](https://github.com/macfanatic).

## Installation

### Bundler

Add the following to your project's `Gemfile` to work with bundler.

```ruby
gem 'ProMotion-menu'
```

Install with bundler:

```ruby
bundle install
```

### Dependenices
This depends on motion-cocoapods and ProMotion.

### Rakefile

As of [motion-cocoapods](https://github.com/HipByte/motion-cocoapods/compare/1.3.6...1.3.7) v1.3.7, you no longer have to include a pods setup block in your project Rakefile, we can do that for you in the gem.

## Creating and Configuring a Menu
To create a menu in your application, you need to start in your AppDelegate:

```ruby
class AppDelegate < PM::Delegate

  def on_load(app, options)

    # Open the menu with your center view (initially shown) and navigation view(s) (initially hidden)
    open_menu MyGreatAppScreen.new(nav_bar: true), left: NavigationScreen

    # You can get to the instance of the menu at any time if you need to
    self.menu.controller(:left).class.name
    # => NavigationScreen

  end

end
```

### Alternate Approach
If you prefer to keep your menu encapsulated you can create a menu drawer and do your setup there.

```ruby
class MenuDrawer < PM::Menu::Drawer

  def setup
    self.center = MyGreatAppScreen.new(nav_bar: true)
    self.left = NavigationScreen
    self.to_show = [:tap_nav_bar, :pan_nav_bar]
    self.max_left_width = 250
  end

end

class AppDelegate < PM::Delegate

  def on_load(app, options)
    @menu = open MenuDrawer
  end

  def show_menu
    @menu.show :left
  end

end
```

## Gesture Recognition
By default you can show the menu by panning within 20 pts of the bezel and hide it by panning or tapping
the center view. It's possible to override the default behavior:

```ruby

# In AppDelegate
open_menu BodyScreen, right: MenuScreen, to_show: :pan_nav_bar, to_hide: [:pan_nav_bar, :tap_nav_bar]

# From elsewhere in your app
app_delegate.menu.to_show = :pan_center

# The following gestures are provided:

  # For to_show:
  :pan_nav_bar  # Pan anywhere on the navigation bar
  :pan_content  # Pan anywhere on the center view
  :pan_center   # Alias of above
  :pan_bezel    # Pan anywhere within 20 pts of the bezel
  :all          # All of the above
  :none         # No gesture recognition

  # For to_hide:
  :pan_nav_bar   # Pan anywhere on the navigation bar
  :pan_content   # Pan anywhere on the center view
  :pan_center    # Alias of above
  :pan_bezel     # Pan anywhere within the bezel of the center view
  :tap_nav_bar   # Tap the navigation bar
  :tap_content   # Tap the center view
  :tap_center    # Alias of above
  :pan_menu      # Pan anywhere on the drawer view
  :all           # All of the above
  :none          # No gesture recognition

```

## Toggling the Menu Drawer Current Screen
To make the menu drawer present the menu from anywhere in your app:

```ruby

# Show the menu
app_delegate.menu.show(:left)

# Equivalent to
app_delegate.menu.openDrawerSide MMDrawerSideLeft, animated: true, completion: ->(c) { true }

# Hide the menu
app_delegate.menu.hide

# Equivalent to
app_delegate.menu.closeDrawerAnimated animated: true, completion: ->(c) { true }

# Actually toggle the menu between open/closed states
app_delegate.menu.toggle(:left)
app_delegate.menu.toggle_left

# Equivalent to
app_delegate.menu.toggleDrawerSide MMDrawerSideLeft, animated: true, completion: ->(c) { true }

# You can also adjust the Menu Drawer width
app_delegate.menu.max_left_width = 250

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
        action: :swap_center_controller,
        arguments: HomeScreen
      }]
    }]
  end

  def swap_center_controller(screen_class)
    app_delegate.menu.center_controller = screen_class
  end

end
```

## More Information

Be sure to check out more documenation from the [cocoapod itself](http://cocoadocs.org/docsets/MMDrawerController/0.5.6/), for fun things such as gesture support for showing or dismissing drawers, custom UIBarButtonItems and more.

### Help

ProMotion is not only an easy DSL to get started. The community is very helpful and
welcoming to new RubyMotion developers. We don't mind newbie questions.

If you need help, feel free to open an issue on GitHub. If we don't respond within a day, tweet us a link to the issue -- sometimes we get busy.

### Contributing

See [CONTRIBUTING.md](https://github.com/clearsightstudio/ProMotion/blob/master/CONTRIBUTING.md).

### Primary Contributors

* Matt Brewer: [@macfanatic](https://github.com/macfanatic)
* Ryan Linton: [@ryanlntn](https://twitter.com/ryanlntn)
* Jason Stirk: [@jstirk](https://github.com/jstirk)
* Mark Rickert: [@markrickert](https://twitter.com/markrickert)
* Jamon Holmgren: [@jamonholmgren](https://twitter.com/jamonholmgren)
* [Many others](https://github.com/clearsightstudio/ProMotion-menu/graphs/contributors)
