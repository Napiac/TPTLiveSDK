Pod::Spec.new do |s|
  s.name = "TPTLiveBraceBusinessMoudle"
  s.version = "1.0.0"
  s.summary = "A short description of TPTLiveBraceBusinessMoudle."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"luoguilin"=>"lgl023@163.com"}
  s.homepage = "http://gitlab.3yakj.com/TPT_iOS/TPTLiveBraceBusinessMoudle"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '12.0'
  s.ios.vendored_framework   = 'TPTLiveBraceBusinessMoudle.framework'

  
  s.ios.resource_bundles = {
    'TPTLiveBraceBusinessMoudle' => ['TPTLiveBraceBusinessMoudle.framework/Resources/TPTLiveBraceBusinessMoudle.bundle/*'],
  }
  
  s.dependency 'TPTCoreMoudle'
  s.dependency 'TPTManagerMoudle'
  s.dependency 'TPTHTTPRequestMoudle'
  s.dependency 'TPTUIGeneralMoudle'
  s.dependency 'TPTV2RouterMoudle'
  s.dependency 'JXCategoryView'
  s.dependency 'JXPagingView/Pager'
end
