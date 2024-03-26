#
# Be sure to run `pod lib lint TPTUIGeneralMoudle.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
# 发布
# pod repo push TPTSpecs TPTUIGeneralMoudle.podspec --sources='http://gitlab.3yakj.com/TPT_iOS/TPTSpecs.git,https://github.com/CocoaPods/Specs.git' --allow-warnings --use-libraries

Pod::Spec.new do |s|
  s.name             = 'TPTUIGeneralMoudle'
  s.version          = '7.4.3'
  s.summary          = 'A short description of TPTUIGeneralMoudle.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC
  
  s.homepage         = 'http://gitlab.3yakj.com/TPT_iOS/TPTUIGeneralMoudle'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Napiac' => '1280367284@qq.com' }
  s.source           = { :git => 'http://gitlab.3yakj.com/TPT_iOS/TPTUIGeneralMoudle.git', :tag => s.version.to_s }
  s.static_framework = true

  s.ios.deployment_target = '12.0'
  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'arm64' }

  s.source_files = 'TPTUIGeneralMoudle/Classes/**/*'
  s.dependency 'SVGAPlayer', '2.5.7'
  s.dependency 'Protobuf' , '3.22.4'
  s.dependency 'SDCycleScrollView'
  s.dependency 'TPTV2RouterMoudle'
  s.dependency 'Protobuf', '3.22.4'
  s.dependency 'QGVAPlayer', '1.0.19'
  s.dependency 'TPTCoreMoudle'

  s.resource_bundles = {
    'TPTUIGeneralMoudle' => ['TPTUIGeneralMoudle/Assets/*']
  }
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
