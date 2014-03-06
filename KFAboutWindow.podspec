#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "KFAboutWindow"
  s.version          = "0.1.0"
  s.summary          = "An about window used in all KFI OSX products."
  s.description  = <<-DESC
                   This is an about window similar to Xcode's. Additionally it can handle CocoaPods
                   Acknowledgements.plist – with one button click you have a list of all used Pods and
                   their licences.
                   DESC
  s.homepage         = "http://kfi-apps.com/cocoapods/"
  s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "rico becker" => "rico.becker@kf-interactive.com" }
  s.source           = { :git => "http://EXAMPLE/NAME.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ricobeck'

  s.osx.deployment_target = '10.8'
  s.requires_arc = true

  s.osx.source_files = 'Classes/**/*'
  s.osx.resources = 'Assets/osx/*'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'

  s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'QuartzCore'

end