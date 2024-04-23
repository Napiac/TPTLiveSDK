Pod::Spec.new do |s|
  s.name = "TPTUIGeneralMoudle"
  s.version = "7.4.3"
  s.summary = "A short description of TPTUIGeneralMoudle."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Napiac"=>"1280367284@qq.com"}
  s.homepage = "http://gitlab.3yakj.com/TPT_iOS/TPTUIGeneralMoudle"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  
  s.ios.deployment_target    = '12.0'
  s.ios.vendored_framework   = 'TPTUIGeneralMoudle.framework'

  s.resource_bundles = {
    'TPTUIGeneralMoudle' => ['TPTUIGeneralMoudle.framework/Resources/TPTUIGeneralMoudle.bundle/*']
  }

  s.frameworks = 'AVKit'
  s.frameworks = 'Photos'

  s.dependency 'SVGAPlayer', '2.5.7'
  s.dependency 'Protobuf' , '3.22.4'
  s.dependency 'SDCycleScrollView'
  s.dependency 'TPTV2RouterMoudle'
  s.dependency 'Protobuf', '3.22.4'
  s.dependency 'QGVAPlayer', '1.0.19'
  s.dependency 'TPTCoreMoudle'
end
