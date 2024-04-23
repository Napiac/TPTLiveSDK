//
//  UIGeneralImagePickerUtil.h
//  TPTUIGeneralMoudle
//
//  Created by wangyin on 2022/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ImagePickerBlock)(UIImage *image);

@interface UIGeneralImagePickerUtil : NSObject



/**
 *  调用系统相机/相册
 *  @param allowEditing 是否允许编辑
 *  @param paddingView 顶部paddingview
 *  @param handler      选取图片后的回调
 */
- (void)pickImageEditing:(BOOL)allowEditing
       insertPaddingView:(UIView *)paddingView
                  fromVC:(UIViewController *)vc
                 handler:(ImagePickerBlock)handler;


/**
 *  调用系统相机/相册
 *  @param allowEditing 是否允许编辑
 *  @param handler      选取图片后的回调
 */
- (void)pickImageEditing:(BOOL)allowEditing
                  fromVC:(UIViewController *)vc
                 handler:(ImagePickerBlock)handler;

- (void)onCameraPickImageEditing:(BOOL)allowEditing
                          fromVC:(UIViewController *)vc
                         handler:(ImagePickerBlock)handler;


@end

NS_ASSUME_NONNULL_END
