//
//  FollowUserHelper.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/9/29.
//

/// 关注用户的帮助类
#import <Foundation/Foundation.h>

/// 关注用户的通知携带的结构体参数
typedef struct _FollowUserListenerStruct {
    NSString * _Nullable followUserId;
    BOOL followStatus;
} FollowUserListenerStruct;

/// 关注某用户的通知
static NSString * _Nullable const kNotifier_Follow_User = @"kNotifier_Follow_User";

NS_ASSUME_NONNULL_BEGIN

@interface FollowUserHelper : NSObject

NSValue * _Nullable FetchValueWithFollowListener(FollowUserListenerStruct followUserStruct);
FollowUserListenerStruct FetchFollowListenerWithValue(NSValue * value);

@end

NS_ASSUME_NONNULL_END
