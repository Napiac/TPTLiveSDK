//
//  LiveBraceMoreLivePanelViewController.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by 田建波 on 2022/9/6.
//

//更多直播
#import "LiveBraceTransitionPopViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiveBraceMoreLivePanelViewController : LiveBraceTransitionPopViewController

/// 是否内部自动跳转
@property(nonatomic, assign)BOOL automaticJump;

/// 跳转
- (void)modalJumpInController:(UICommonViewController *)controller;

@end

NS_ASSUME_NONNULL_END
