require 'motion-cocoapods'
require 'ProMotion'

unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Project::App.setup do |app|

  # Add all the files in our lib folder
  # WE ADD THESE AT THE END OF THE FILE LISTING!
  # This way, we can be sure that ProMotion itself has been compiled, but before any of the app's files are compiled.
  Dir.glob(File.join(File.dirname(__FILE__), 'pro_motion_slide_menu/**/*.rb')).each do |file|
    app.files << file
  end

  app.pods do
    pod 'MMDrawerController', '~> 0.5'
  end

end
