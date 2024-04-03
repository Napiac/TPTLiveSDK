//
//  LiveBraceMoreLivePanelChildViewController.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by 田建波 on 2022/9/8.
//

//更多直播分页控制器
#import <TPTCoreMoudle/UICommonViewController.h>
#import <JXPagingView/JXPagerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveBraceMoreLivePanelChildViewController : UICommonViewController<JXPagerViewListViewDelegate>

/// 父控制器
@property(nonatomic, weak, nullable)UIViewController * fatherViewController;

@property(nonatomic, strong, readonly)UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
