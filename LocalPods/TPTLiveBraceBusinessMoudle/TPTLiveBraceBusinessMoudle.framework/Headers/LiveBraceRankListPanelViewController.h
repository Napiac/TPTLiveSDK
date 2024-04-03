//
//  LiveBraceRankListPanelViewController.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by 田建波 on 2022/8/31.
//


//榜单面板（活跃主播、人气主播）
#import <TPTCoreMoudle/UICommonViewController.h>
@class CustomModalJumpConfig;

NS_ASSUME_NONNULL_BEGIN

@interface LiveBraceRankListPanelViewController : UICommonViewController

/// 用户ID
@property(nonatomic, strong)NSString * userId;
///** 当前选中的index */
//@property(nonatomic, assign)NSInteger currenIndex;
///// title 数组，格式：@{@"0":@"活跃name",@"1":@"人气name"，@"2":@"pk赛季name"}
//@property(nonatomic, copy)NSArray * titleArray;
/// 选中的Key
@property(nonatomic, copy)NSString * selectedRequestKey;
/// pager数据源
@property(nonatomic, copy)NSArray * contents;


- (void)setLiveBraceRankListPanelViewParams:(NSDictionary *)params;

/// 跳转
- (CustomModalJumpConfig *)modalJumpInController:(UICommonViewController *)controller;

@end

NS_ASSUME_NONNULL_END
