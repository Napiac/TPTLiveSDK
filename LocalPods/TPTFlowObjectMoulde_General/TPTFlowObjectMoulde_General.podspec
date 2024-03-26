Pod::Spec.new do |s|
  s.name = "TPTFlowObjectMoulde_General"
  s.version = "7.4.2"
  s.summary = "A short description of TPTFlowObjectMoulde_General."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Napiac"=>"1280367284@qq.com"}
  s.homepage = "http://gitlab.3yakj.com/TPT_iOS/TPTFlowObjectMoulde"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.dependency 'TXLiteAVSDK_Professional', '11.1.14143'  
  s.dependency 'TPTV2RouterMoudle'
  s.dependency 'ReactiveObjC'

  s.ios.deployment_target    = '12.0'
  s.ios.vendored_framework   = 'TPTFlowObjectMoulde_General.framework'
  
  s.dependency 'TPTV2RouterMoudle'
  s.dependency 'ReactiveObjC'
  s.dependency 'TXLiteAVSDK_Professional', '11.1.14143'
end
