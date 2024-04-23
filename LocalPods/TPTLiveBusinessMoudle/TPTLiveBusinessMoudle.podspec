Pod::Spec.new do |s|
  s.name = "TPTLiveBusinessMoudle"
  s.version = "1.0.0"
  s.summary = "A short description of TPTLiveBusinessMoudle."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Napiac"=>"1280367284@qq.com"}
  s.homepage = "http://gitlab.3yakj.com/TPT_iOS/TPTLiveBusinessMoudle"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '12.0'
  
  s.ios.vendored_framework = 'TPTLiveBusinessMoudle.framework'


  s.ios.frameworks = ['AVFoundation', 'AudioToolbox', 'AVKit', 'MediaPlayer']

  s.ios.resource_bundles = {
    'TPTLiveBusinessMoudle_Live' => ['TPTLiveBusinessMoudle.framework/Resources/TPTLiveBusinessMoudle_Live.bundle/*'],
    'TPTLiveBusinessMoudle_LiveV2Brace' => ['TPTLiveBusinessMoudle.framework/Resources/TPTLiveBusinessMoudle_LiveV2Brace.bundle/*'],
  }
  
  s.dependency 'TPTCoreMoudle'
  s.dependency 'TPTV2RouterMoudle'
  s.dependency 'TPTManagerMoudle'
  s.dependency 'TPTHTTPRequestMoudle'
  s.dependency 'TPTUIGeneralMoudle'
  s.dependency 'TPTFlowObjectMoulde_General'
  s.dependency 'TPTFlowObjectMoulde_Player'
  s.dependency 'TPTFlowObjectMoulde_RadioRoomTRTC'

  s.dependency 'JXCategoryView'
  s.dependency 'JXPagingView/Pager'
end
