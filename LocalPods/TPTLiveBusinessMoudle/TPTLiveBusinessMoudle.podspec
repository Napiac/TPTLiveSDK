Pod::Spec.new do |s|
  s.name = "TPTLiveBusinessMoudle"
  s.version = "1.0.0"
  s.summary = "A short description of TPTLiveBusinessMoudle."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Napiac"=>"1280367284@qq.com"}
  s.homepage = "http://gitlab.3yakj.com/TPT_iOS/TPTLiveBusinessMoudle"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target = '12.0'
  
  s.ios.vendored_frameworks = [
    'LiveSDK/TPTLiveBusinessMoudle.framework',
#    'LiveSDK/TPTFlowObjectMoulde_General.framework',
#    'LiveSDK/TPTFlowObjectMoulde_Player.framework',
#    'LiveSDK/TPTFlowObjectMoulde_RadioRoomTRTC.framework'
  ]

  s.ios.frameworks = ['AVFoundation', 'AudioToolbox', 'AVKit', 'MediaPlayer']

  s.ios.resource_bundles = {
    'TPTLiveBusinessMoudle_Live' => ['LiveSDK/TPTLiveBusinessMoudle.framework/Resources/TPTLiveBusinessMoudle_Live.bundle/*']
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
