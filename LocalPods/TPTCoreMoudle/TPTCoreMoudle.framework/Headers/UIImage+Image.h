//
//  UIImage+Image.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DefaultImageType) {
    /// 灰色
    DefaultImageType_Gray = 0,
    /// 彩色
    DefaultImageType_MultiColor
};

typedef NS_ENUM(NSUInteger, GradientDirection) {
    /// 从上到下
    GradientDirection_TopToBottom = 0,
    /// 从左到右
    GradientDirection_LeftToRight = 1,
    /// 左上到右下
    GradientDirection_UpleftToLowright = 2,
    /// 右上到左下
    GradientDirection_UprightToLowleft = 3,
};


NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Image)

/// 默认头像
UIImage * _Nullable DefaultAvatarImage(DefaultImageType type);


/// 图片Loading时占位图
UIImage * _Nullable PlaceholderImage(DefaultImageType type);


/// 加载图片
/// @param imageName 图片名字
/// @param bundleName 图片所属的bundle
/// @param inMoudleClassName 在相关模块里的Class
UIImage * _Nullable LoadImage(NSString * imageName,
                              NSString * bundleName,
                              NSString * inMoudleClassName);



/// 裁切图片大小
/// @param imageName 图片名字
/// @param size size
+ (UIImage *)cutImageWithName:(NSString *)imageName imageSize:(CGSize)size;


/// 创建一个纯色的图片
/// @param color color
/// @param size size
+ (UIImage *)createImageWithColor:(UIColor *)color imageSize:(CGSize)size;


/// 生成渐变色图片 USE:self.view.layer.contents = (__bridge id)(渐变图片.CGImage)
/// @param colors 颜色的数组
/// @param area 剪标区域
/// @param direction 渐变方法 (Default：从上到下)
+ (UIImage *)gradientColor:(NSArray *)colors imageArea:(CGSize)area gradientDirection:(GradientDirection)direction;
+ (UIImage *)gradientColor:(NSArray *)colors imageArea:(CGSize)area;

/// 给图片切圆角
/// @param cornerRadius 圆角
- (UIImage *)cornerImageWithRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
