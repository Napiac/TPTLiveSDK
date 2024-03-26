Pod::Spec.new do |s|
  s.name         = 'YYText'
  s.summary      = 'YYText Fork库 版本号从10.0.0开始'
  s.version      = '10.0.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Napiac' => '1280367284@qq.com' }
  s.social_media_url = 'http://gitlab.xxxx.com/xxxx/TPTFORKYYText'
  s.homepage     = 'http://gitlab.xxxx.com/xxxx/TPTFORKYYText'
  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.source       = { :git => 'http://gitlab.xxxx.com/xxxx/TPTFORKYYText.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'YYText/**/*.{h,m}'
  s.public_header_files = 'YYText/**/*.{h}'
  
  s.frameworks = 'UIKit', 'CoreFoundation','CoreText', 'QuartzCore', 'Accelerate', 'MobileCoreServices'

end
