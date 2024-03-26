//
//  NSData+Base64.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Base64)



/// 字符串base64后转data
/// @param string string
/// 传入字符串 base64后的data
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;


/// NSData转string
/// @param wrapWidth 换行长度  76  64
/// base64后的字符串
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;


/// NSData转string 换行长度默认64
/// base64后的字符串
- (NSString *)base64EncodedString;

@end

NS_ASSUME_NONNULL_END
