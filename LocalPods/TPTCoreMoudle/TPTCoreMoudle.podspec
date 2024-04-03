Pod::Spec.new do |s|
  s.name = "TPTCoreMoudle"
  s.version = "1.0.0"
  s.summary = "A short description of TPTCoreMoudle."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Napiac"=>"1280367284@qq.com"}
  s.homepage = "http://gitlab.3yakj.com/TPT_iOS/TPTCoreMoudle"
  s.description = "TODO: Add long description of the pod here."
  s.frameworks = ["UIKit", "Foundation"]
  s.source = { :path => '.' }

  s.ios.deployment_target    = '12.0'
  s.ios.vendored_framework   = 'TPTCoreMoudle.framework'
  
  s.ios.resource_bundles = {
    'TPTCoreMoudle_Images' => ['TPTCoreMoudle.framework/Resources/TPTCoreMoudle_Images.bundle/*'],
    'TPTCoreMoudle_Resource' => ['TPTCoreMoudle.framework/Resources/TPTCoreMoudle_Resource.bundle/*']
  }
  s.dependency 'Masonry'
  s.dependency 'ReactiveObjC'
  s.dependency 'SDWebImage', '5.18.0'
  s.dependency 'YYText', '10.0.0'
  s.dependency 'YYModel'
  s.dependency 'MBProgressHUD'
  s.dependency 'FDFullscreenPopGesture'
  s.dependency 'IQKeyboardManager', '6.5.10'
  s.dependency 'MJRefresh'
  s.dependency 'lottie-ios', '2.5.2'
  s.dependency 'TPTV2RouterMoudle'
  
  s.frameworks = 'WebKit','StoreKit','AppTrackingTransparency','AdSupport', 'CoreLocation'

end
