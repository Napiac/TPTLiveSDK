//
//  UIScrollView+Refresh.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/8/12.
//

#import <UIKit/UIKit.h>

typedef void(^RefreshHandler)(void);

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Refresh)

/// 下拉刷新
- (id)addPullRefresh:(RefreshHandler)handler;
- (void)stopPullRefrshing;


/// 上拉加载更多
- (id)addLoadingMore:(RefreshHandler)handler;
- (void)stopLoadingMore;
- (void)removeLoadingMore;

- (void)hideLoadingMore;
- (void)showLoadingMore;


/// 上、下拉都停止
- (void)stopRefresh;

@end

NS_ASSUME_NONNULL_END
