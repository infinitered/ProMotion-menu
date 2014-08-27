unless defined?(Motion::Project::Config)
  raise "The ProMotion gem must be required within a RubyMotion project Rakefile."
end

require 'motion-cocoapods'
require 'ProMotion'

Motion::Project::App.setup do |app|
  core_lib = File.join(File.dirname(__FILE__), 'ProMotion')
  insert_point = app.files.find_index { |file| file =~ /^(?:\.\/)?app\// } || 0

  Dir.glob(File.join(File.dirname(__FILE__), 'ProMotion/menu/**/*.rb')).each do |file|
    app.files << file
  end

  app.pods do
    pod 'MMDrawerController', '~> 0.5'
  end
end

