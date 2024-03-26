Pod::Spec.new do |s|
  s.name = "TPTFlowObjectMoulde_Player"
  s.version = "7.4.2"
  s.summary = "A short description of TPTFlowObjectMoulde_Player. APP\u4E2D\u4F7F\u7528\u7684\u64AD\u653E\u5668\u51FA\u5904"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Napiac"=>"1280367284@qq.com"}
  s.homepage = "http://gitlab.3yakj.com/TPT_iOS/TPTFlowObjectMoulde"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '12.0'
  s.ios.vendored_framework   = 'TPTFlowObjectMoulde_Player.framework'
  
  s.dependency 'TPTFlowObjectMoulde_General'
end
