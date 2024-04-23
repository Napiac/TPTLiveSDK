Pod::Spec.new do |s|
  s.name = "TPTGeneralWebsocketBusinessModule"
  s.version = "7.4.1"
  s.summary = "A short description of TPTGeneralWebsocketBusinessModule."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"wangyin"=>"1113867967@qq.com"}
  s.homepage = "http://gitlab.3yakj.com/TPT_iOS/TPTGeneralWebsocketBusinessModule.git"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '12.0'
  s.ios.vendored_framework   = 'TPTGeneralWebsocketBusinessModule.framework'
  
  s.ios.resource_bundles = {
    'TPTGeneralWebsocketBusinessModule' => ['TPTGeneralWebsocketBusinessModule.framework/Resources/TPTGeneralWebsocketBusinessModule.bundle/*']
  }
  s.dependency 'TPTCoreMoudle'
  s.dependency 'ReactiveObjC'
  s.dependency 'TPTManagerMoudle'
  s.dependency 'TPTV2RouterMoudle'
  s.dependency 'SocketRocket'
  s.dependency 'TPTUIGeneralMoudle'
  

end
