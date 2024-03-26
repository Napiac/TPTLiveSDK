//
//  NSString+String.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (String)

/// 去掉空白格
- (NSString *)makeTrim;

/// 检查手机号码格式
- (BOOL)isMobilePhone;

/// 检查手机号码格式
/// - Parameter regex: 正则
- (BOOL)isMobilePhoneTextWithRegex:(NSString *)regex;

/// 将数字加上汉字单位
- (NSString *)numberAddChineseUnit;

/// MD5加密 32位小写
- (NSString *)md5EncryptTo32Bit;


/// 计算Text宽度
/// @param font 字体
/// @param maxHeight 最大高度
- (CGFloat)fetchTextWidthWithFont:(UIFont *)font
                    textMaxHeight:(CGFloat)maxHeight;



/// 计算Text高度
/// @param font 字体
/// @param maxWidth 最大宽度
- (CGFloat)fetchTextHeightWithFont:(UIFont *)font
                      textMaxWidth:(CGFloat)maxWidth;
@end

NS_ASSUME_NONNULL_END
