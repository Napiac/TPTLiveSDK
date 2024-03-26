Pod::Spec.new do |s|
  s.name = "TPTFlowObjectMoulde_RadioRoomTRTC"
  s.version = "7.4.2"
  s.summary = "A short description of TPTFlowObjectMoulde_RadioRoomTRTC. \u7535\u53F0\u623F\u4F7F\u7528\u7684TRTC"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Napiac"=>"1280367284@qq.com"}
  s.homepage = "http://gitlab.3yakj.com/TPT_iOS/TPTFlowObjectMoulde"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '12.0'
  s.ios.vendored_framework   = 'TPTFlowObjectMoulde_RadioRoomTRTC.framework'
  
  s.dependency 'ReactiveObjC'

   s.dependency 'TPTV2RouterMoudle'
   s.dependency 'TPTFlowObjectMoulde_General'
end
