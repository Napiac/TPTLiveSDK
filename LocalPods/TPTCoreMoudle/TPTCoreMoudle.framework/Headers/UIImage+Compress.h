//
//  UIImage+Compress.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//
///压缩图片
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Compress)


#pragma mark -
#pragma mark - 推荐API

/**
 Compress a UIImage to the specified ratio
 
 @param image The image to compress
 @param ratio The compress ratio to compress to
 
 */
+ (UIImage *)compressImage:(UIImage *)image
             compressRatio:(CGFloat)ratio;

/**
 Compress a UIImage to the specified ratio with a max ratio compression
 
 @param image The image to compress
 @param ratio The compress ratio to compress to
 @param maxRatio The maximum compression ratio for the image
 
 */
+ (UIImage *)compressImage:(UIImage *)image
             compressRatio:(CGFloat)ratio
          maxCompressRatio:(CGFloat)maxRatio;

/**
 Compress a remote UIImage to the specified ratio with a max ratio compression
 
 @param url The remote image URL to compress
 @param ratio The compress ratio to compress to
 
 */
+ (UIImage *)compressRemoteImage:(NSString *)url
                   compressRatio:(CGFloat)ratio;

/**
 Compress a remote UIImage to the specified ratio with a max ratio compression
 
 @param url The remote image URL to compress
 @param ratio The compress ratio to compress to
 @param maxRatio The maximum compression ratio for the image
 
 */
+ (UIImage *)compressRemoteImage:(NSString *)url
                   compressRatio:(CGFloat)ratio
                maxCompressRatio:(CGFloat)maxRatio;




#pragma mark -
#pragma mark - 下面方法会堵塞线程



/// 压缩上传图片到指定字节
/// @param image 牙刷的图片
/// @param maxLength 牙刷后最大字节大小
/// @param maxWidth 设置图片最大边宽
+ (NSData *)compressImage:(UIImage *)image toMaxLength:(NSInteger)maxLength maxWidth:(NSInteger)maxWidth;



/// 获得指定size的图片
/// @param image 原始图片
/// @param newSize 指定的size
+ (UIImage *)resizeImage:(UIImage *)image withNewSize:(CGSize)newSize;



/// 通过指定图片最长边，获得等比例的图片size
/// @param image 原始图片
/// @param imageLength 图片允许的最大宽度（高度）
+ (CGSize)scaleImage:(UIImage *)image withLength:(CGFloat)imageLength;


@end

NS_ASSUME_NONNULL_END
