Pod::Spec.new do |s|
  s.name = "TPTBlackBoxTestingMoudle"
  s.version = "1.2.0"
  s.summary = "A short description of TPTBlackBoxTestingMoudle."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Napiac"=>"1280367284@qq.com"}
  s.homepage = "http://gitlab.3yakj.com/TPT_iOS/TPTBlackBoxTestingMoudle"
  s.description = "TODO: Add long description of the pod here."
  s.frameworks = "CoreServices"
  s.source = { :path => '.' }

  s.ios.deployment_target    = '12.0'
  s.ios.vendored_framework   = 'TPTBlackBoxTestingMoudle.framework'
  
  s.frameworks = 'CoreServices'
  s.dependency 'FMDB'
  s.dependency 'TPTV2RouterMoudle'
end
