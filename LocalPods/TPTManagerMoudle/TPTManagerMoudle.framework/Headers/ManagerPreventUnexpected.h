//
//  ManagerPreventUnexpected.h
//  TPTManagerMoudle
//
//  Created by Napiac on 2023/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagerPreventUnexpected : NSObject
/// 设备是否越狱
+ (BOOL)isDeviceJailbreak;

@end

NS_ASSUME_NONNULL_END
