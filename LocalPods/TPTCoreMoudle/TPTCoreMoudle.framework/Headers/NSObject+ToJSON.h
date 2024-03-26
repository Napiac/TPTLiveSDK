//
//  NSObject+ToJSON.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ToJSON)

/// 转换成JSON串字符串（没有可读性
- (NSString *)conversionJSONString;


///将数据对象转化为Data
- (NSData *)conversionJSONData;

/// 将object转换为数据对象
- (id)coversionObject;

@end

NS_ASSUME_NONNULL_END
