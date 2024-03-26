Pod::Spec.new do |s|
  s.name = "TPTV2RouterMoudle"
  s.version = "1.3.0"
  s.summary = "A short description of TPTV2RouterMoudle."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Napiac"=>"1280367284@qq.com"}
  s.homepage = "http://gitlab.3yakj.com/TPT_iOS/TPTV2RouterMoudle"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '10.0'
  s.ios.vendored_framework   = 'TPTV2RouterMoudle.framework'
end
