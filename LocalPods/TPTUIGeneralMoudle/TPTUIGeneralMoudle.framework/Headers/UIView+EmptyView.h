//
//  UIView+EmptyView.h
//  TPTUIGeneralMoudle
//
//  Created by 凡骄 on 2022/8/24.
//

#import <UIKit/UIKit.h>
@class UIGeneralEmptyView;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (EmptyView)

@property (nonatomic, strong, nullable) UIGeneralEmptyView *emptyView;

- (void)showEmptyView;
- (void)hideEmptyView;
- (void)scrollEmptyViewReload;

@end

NS_ASSUME_NONNULL_END
