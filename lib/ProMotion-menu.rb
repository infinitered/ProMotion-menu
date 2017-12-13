unless defined?(Motion::Project::Config)
  raise "The ProMotion gem must be required within a RubyMotion project Rakefile."
end

require 'motion-cocoapods'
require 'ProMotion'

Motion::Project::App.setup do |app|
  core_lib = File.join(File.dirname(__FILE__), 'ProMotion/menu')
  insert_point = app.files.find_index { |file| file =~ /^(?:\.\/)?app\// } || 0

  Dir.glob(File.join(core_lib, '**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end

  # For compatibility with libraries that set detect_dependencies to false
  app.files_dependencies({
    "#{core_lib}/drawer.rb" => [ "#{core_lib}/visibility.rb", "#{core_lib}/gestures.rb" ],
    "#{core_lib}/delegate.rb" => [ "#{core_lib}/drawer.rb" ],
  })
  
  app.pods do
    pod 'MMDrawerController', '~> 0.6'
  end
end

