//
//  TPTGeneralWebsocketBusinessModule.h
//  Pods
//
//  Created by wangyin on 2023/2/7.
//

#ifndef TPTGeneralWebsocketBusinessModule_h
#define TPTGeneralWebsocketBusinessModule_h

#import <TPTCoreMoudle/UIImage+Image.h>




/// WS场景- 上报
static  NSString * _Nullable const kGeneralWS_Scene_Single = @"single";
/// WS场景- 直播间
static NSString * _Nullable const kGeneralWS_Scene_LiveRoom = @"live";

/// 上报成功
static NSString * _Nullable const kGeneralWS_SingleSucess = @"success";
/// 上报失败
static NSString * _Nullable const kGeneralWS_SingleFailToken = @"fail_token";
/// 余额变更
static NSString * _Nullable const kGeneralWS_UserBalanceChanged = @"up_user_balance";




/// Bundle名
static NSString * _Nullable const kGeneralWsBusinessBundleName = @"TPTGeneralWebsocketBusinessModule";

/// 模块里的Class Name
static NSString * _Nullable const kInGeneralWsBusinessMoudleClassName = @"GeneralWSUtil";

NS_INLINE UIImage * _Nullable GeneralWsBusinessBundleLoadImage(NSString * _Nullable imageName) {
    return LoadImage(imageName, kGeneralWsBusinessBundleName, kInGeneralWsBusinessMoudleClassName);
}


#endif /* TPTGeneralWebsocketBusinessModule_h */
