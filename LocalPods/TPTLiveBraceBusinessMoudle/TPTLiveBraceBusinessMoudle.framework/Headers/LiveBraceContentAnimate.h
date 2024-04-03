//
//  LiveBraceContentAnimate.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by 田建波 on 2022/9/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveBraceContentAnimate : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithPresentting:(BOOL)isPresentting;

- (void)presentAnimationUsingTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)dismissAnimationUsingTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;

@end

NS_ASSUME_NONNULL_END
