//
//  TPTManagerMoudle.h
//  TPTManagerMoudle
//
//  Created by Napiac on 2022/7/29.
//

#ifndef TPTManagerMoudle_h
#define TPTManagerMoudle_h

#import "UserManager.h"

/// 用户登录成功通知
static NSString * _Nullable const kNotifier_User_Login_Success = @"Notifier_User_Login_Success";
/// 用户退出成功通知
static NSString * _Nullable const kNotifier_User_Logout_Success = @"Notifier_User_Logout_Success";
/// 用户数据被修改成功通知
static NSString * _Nullable const kNotifier_UserData_Update_Success = @"Notifier_UserData_Update_Success";


NS_INLINE NSBundle * _Nullable LoadManagerMoudleBundle(void) {
    NSBundle * bundle = [NSBundle bundleForClass:UserManager.class];
    if (!bundle) {
        return nil;
    }
    NSString * bundleName = [NSString stringWithFormat:@"TPTManagerMoudle.bundle"];
    NSString * resourcePath = [bundle pathForResource:bundleName ofType:nil];
    bundle = [NSBundle bundleWithPath:resourcePath];
    return bundle;
}

#endif
