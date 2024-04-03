//
//  TPTLiveBraceBusinessMoudle.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by 田建波 on 2022/9/2.
//

#ifndef TPTLiveBraceBusinessMoudle_h
#define TPTLiveBraceBusinessMoudle_h


/// Bundle名
static NSString * _Nullable const kLiveBraceBusinessBundleName = @"TPTLiveBraceBusinessMoudle";

/// 模块里的Class Name
static NSString * _Nullable const kInLiveBraceBusinessMoudleClassName = @"TPTLiveBraceBusinessMoudle";

/// 用户改变关注状态通知
static NSString * _Nullable const kNotifier_User_FollowStates_Success = @"Notifier_User_FollowStates_Success";

NS_INLINE UIImage * _Nullable LiveBraceBusinessBundleLoadImage(NSString * _Nullable imageName) {
    return LoadImage(imageName, kLiveBraceBusinessBundleName, kInLiveBraceBusinessMoudleClassName);
}

#endif /* TPTLiveBraceBusinessMoudle_h */

