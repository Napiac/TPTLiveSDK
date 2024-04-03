//
//  LiveBraceRankListPanelChildView.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by 田建波 on 2022/9/2.
//

//榜单分页view
#import <TPTCoreMoudle/UICommonView.h>
#import <JXPagingView/JXPagerView.h>

@class CustomModalJumpConfig;
@class LiveBraceRankListUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface LiveBraceRankListPanelChildView : UICommonView<JXPagerViewListViewDelegate>
/// 当前主播在当前榜单排行信息model
@property (nonatomic, strong, nullable, readonly) LiveBraceRankListUserModel *rankListUserModel;
@property(nonatomic, strong, readonly)UITableView * tableView;
/// 父控制器
@property(nonatomic, weak, nullable)UIViewController * fatherViewController;
/// 父控制器的config
@property(nonatomic, strong)CustomModalJumpConfig * modalConfig;
/// 列表需要的参数
/// 格式：@{@"requestKeyword":LiveRankListRequestKeyword_PKRankList,
///        @"displayName":@"PK赛季",
///        @"isPKList":@(true)}
@property(nonatomic, copy)NSDictionary * rankListNeedParams;

@end

NS_ASSUME_NONNULL_END
