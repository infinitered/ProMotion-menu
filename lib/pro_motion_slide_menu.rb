unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Project::App.setup do |app|

  # Add all the files in our lib folder
  Dir.glob(File.join(File.dirname(__FILE__), 'pro_motion_slide_menu/**/*.rb')).each do |file|
    app.files.unshift(file)
  end

  # We have a cocoapod that we rely on
  # THIS WON'T WORK until the following issue is resolved with motion-cocoapods
  # https://github.com/HipByte/motion-cocoapods/issues/38
  #
  # app.pods do
    # pod 'PKRevealController'
  # end

end
