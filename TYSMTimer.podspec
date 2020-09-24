#
# Be sure to run `pod lib lint TYSMTimer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TYSMTimer'
  s.version          = '0.1.0'
  s.summary          = 'Thank you so mush'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
take me down to the paradise city where the grass is green and the girls are pretty
                       DESC

  s.homepage         = 'git@github.com:cookies-J/TYSMTimer.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cookies-J' => 'cooljele@gmail.com' }
  s.source           = { :git => 'git@github.com:cookies-J/TYSMTimer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'TYSMTimer/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TYSMTimer' => ['TYSMTimer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
