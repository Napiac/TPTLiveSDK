Pod::Spec.new do |s|
  s.name = "TPTHTTPRequestMoudle"
  s.version = "2.0.2"
  s.summary = "A short description of TPTHTTPRequestMoudle."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Napiac"=>"1280367284@qq.com"}
  s.homepage = "http://gitlab.3yakj.com/TPT_iOS/TPTHTTPRequestMoudle"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '12.0'
  s.ios.vendored_framework   = 'TPTHTTPRequestMoudle.framework'
  
  s.dependency 'AFNetworking'
  s.dependency 'TPTV2RouterMoudle'
end
