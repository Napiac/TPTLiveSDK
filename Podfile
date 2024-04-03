source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

platform :ios, '12.0'

def localPods
  pod 'YYText', :path => 'LocalPods/FORKYYText' # 有修改
  pod 'TPTLiveBusinessMoudle', :path => 'LocalPods/TPTLiveBusinessMoudle'
  pod 'TPTGeneralWebsocketBusinessModule', :path => 'LocalPods/TPTGeneralWebsocketBusinessModule'
  pod 'TPTV2RouterMoudle',     :path => 'LocalPods/TPTV2RouterMoudle'
  pod 'TPTCoreMoudle',         :path => 'LocalPods/TPTCoreMoudle'
  pod 'TPTManagerMoudle',      :path => 'LocalPods/TPTManagerMoudle'
  pod 'TPTHTTPRequestMoudle',  :path => 'LocalPods/TPTHTTPRequestMoudle'
  pod 'TPTUIGeneralMoudle',    :path => 'LocalPods/TPTUIGeneralMoudle'
  pod 'TPTBlackBoxTestingMoudle', :path => 'LocalPods/TPTBlackBoxTestingMoudle'
  pod 'TPTFlowObjectMoulde_General', :path => 'LocalPods/TPTFlowObjectMoulde_General'
  pod 'TPTFlowObjectMoulde_Player', :path => 'LocalPods/TPTFlowObjectMoulde_Player'
  pod 'TPTFlowObjectMoulde_RadioRoomTRTC', :path => 'LocalPods/TPTFlowObjectMoulde_RadioRoomTRTC'
end


target 'TPTLiveSDK_Example' do
  localPods
  
  pod 'LookinServer', :configurations => ['Debug']

end




post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['ENABLE_BITCODE'] = 'NO'
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
    end
end


pre_install do |installer|
  # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
  Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
end
