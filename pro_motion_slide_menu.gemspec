require File.expand_path('../lib/pro_motion_slide_menu/version.rb', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'pro_motion_slide_menu'
  s.version       = ProMotionSlideMenu::Version
  s.authors       = ["Matt Brewer"]
  s.email         = 'matt.brewer@me.com'

  s.summary       = "Provides a facebook/Path style slide menu on the left for ProMotion RubyMotion apps."
  s.description   = "Provides a facebook/Path style slide menu on the left for ProMotion RubyMotion apps."

  s.homepage      = "https://github.com/macfanatic/pro_motion_slide_menu"
  s.files         = `git ls-files`.split($\)
  s.test_files    = s.files.grep(%r{^spec/})
  s.require_paths = ['lib']

  s.add_dependency "bubble-wrap"
  s.add_dependency "motion-cocoapods"
  s.add_dependency "ProMotion", '~> 0.5'
  s.add_development_dependency "motion-stump"

end
