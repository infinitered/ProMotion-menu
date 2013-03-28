require "bundler/gem_tasks"

$:.unshift('/Library/RubyMotion/lib')
require 'motion/project'
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'ProMotionSlideMenu'
  app.delegate_class = 'TestAppDelegate'    
end
