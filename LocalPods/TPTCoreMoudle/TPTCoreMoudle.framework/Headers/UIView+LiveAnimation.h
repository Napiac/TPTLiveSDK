//
//  UIView+LiveAnimation.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 直播状态动画
@interface UIView (LiveAnimation)

- (void)addLiveAnimation;


- (void)stopLiveAnimation;

- (void)removeLiveAnimation;

@end

NS_ASSUME_NONNULL_END
