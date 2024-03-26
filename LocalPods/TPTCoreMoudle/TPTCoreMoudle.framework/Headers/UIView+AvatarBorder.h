//
//  UIView+AvatarBorder.h
//  TPTCoreMoudle
//
//  Created by wangyin on 2023/1/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 头像框
@interface UIView (AvatarBorder)

/// 添加头像框 返回头像框imageview对象
/// 重复添加只保留最后一次
/// - Parameter borderFile: 头像框
- (UIImageView *)addAvatarBorder:(id)borderFile;

/// 移除头像框
- (void)removeAvatarBorder;

@end

NS_ASSUME_NONNULL_END
