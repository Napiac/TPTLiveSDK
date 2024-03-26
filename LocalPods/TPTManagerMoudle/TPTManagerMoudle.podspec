Pod::Spec.new do |s|
  s.name = "TPTManagerMoudle"
  s.version = "7.4.9"
  s.summary = "A short description of TPTManagerMoudle."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Napiac"=>"1280367284@qq.com"}
  s.homepage = "http://gitlab.3yakj.com/TPT_iOS/TPTManagerMoudle"
  s.description = "TODO: Add long description of the pod here."
  s.frameworks = ["UIKit", "StoreKit"]
  s.source = { :path => '.' }

  s.ios.deployment_target    = '12.0'
  s.ios.vendored_framework   = 'TPTManagerMoudle.framework'
  
  s.dependency 'FMDB'
  s.dependency 'YYModel'
  s.dependency 'TPTV2RouterMoudle'
  s.dependency 'ReactiveObjC'
  s.frameworks = 'UIKit','StoreKit','AppTrackingTransparency','AdSupport', 'CoreLocation'
end
