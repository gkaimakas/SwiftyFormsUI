#
# Be sure to run `pod lib lint SwiftyFormsUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyFormsUI'
  s.version          = '0.12.4'
  s.summary          = 'UI elements for SwiftyForms'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
		A collection of UI elements that can be used when creating forms with SwiftyForms
                       DESC

  s.homepage         = 'https://github.com/gkaimakas/SwiftyFormsUI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gkaimakas' => 'gkaimakas@gmail.com' }
  s.source           = { :git => 'https://github.com/gkaimakas/SwiftyFormsUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SwiftyFormsUI/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwiftyFormsUI' => ['SwiftyFormsUI/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

	s.frameworks = 'UIKit'
	s.dependency 'SnapKit'
	s.dependency 'SwiftyForms', '~> 0.12.0'
end
