//
//  NSString+Helper.h
//  TPTHTTPRequestMoudle
//
//  Created by Napiac on 2022/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HTTPHelper)

/// 去掉空白格
- (NSString *)HTTPMakeTrim;

/// MD5加密
- (NSString *)HTTPMD5;


/// MD5加密 32位小写
- (NSString *)HTTPMD5To32Bit;
@end


@interface NSObject (HTTPHelper)

/// 转换成JSON串字符串（没有可读性)
- (NSString *)HTTPConversionJSONString;

@end

NS_ASSUME_NONNULL_END
