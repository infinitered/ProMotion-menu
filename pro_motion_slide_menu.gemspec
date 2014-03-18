require File.expand_path('../lib/pro_motion_slide_menu/version.rb', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'pro_motion_slide_menu'
  s.version       = ProMotionSlideMenu::VERSION
  s.authors       = ["Matt Brewer"]
  s.email         = 'matt.brewer@me.com'

  s.summary       = "Provides a facebook/Path style slide menu for ProMotion RubyMotion apps."
  s.description   = "ProMotion DSL integration with PKRevealController cocoapod providing a left and/or right 'slide' out menu complete with gestures for reveal/hide."

  s.homepage      = "https://github.com/macfanatic/pro_motion_slide_menu"
  s.files         = Dir["lib/**/*"] + ["README.md"]
  s.test_files    = Dir["spec/**/*"]
  s.require_paths = ['lib']
  s.license       = "MIT"

  s.add_dependency "motion-cocoapods"
  s.add_dependency "ProMotion", '~> 1'

  s.add_development_dependency "rake"
  s.add_development_dependency "motion-stump"

end
