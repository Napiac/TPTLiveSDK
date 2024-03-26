//
//  NSObject+Helper.h
//  TPTManagerMoudle
//
//  Created by Napiac on 2022/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Helper)
/// 转换成JSON串字符串（没有可读性
- (NSString *)managerConversionJSONString;

/// 将object转换为数据对象
- (id)managerCoversionObject;

- (NSString *)managerURLEncode;
- (NSString *)managerURLDecode;
@end

NS_ASSUME_NONNULL_END
