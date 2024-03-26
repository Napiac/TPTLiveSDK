//
//  UIView+EmptyView.m
//  TPTUIGeneralMoudle
//
//  Created by 凡骄 on 2022/8/24.
//

#import "UIView+EmptyView.h"
#import <objc/runtime.h>
#import "UIGeneralEmptyView.h"

@implementation UIView (EmptyView)

- (void)setEmptyView:(UIGeneralEmptyView *)emptyView {
    if (emptyView != self.emptyView) {
        objc_setAssociatedObject(self, @selector(emptyView), emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIGeneralEmptyView class]]) {
                [view removeFromSuperview];
            }
        }
        self.emptyView.hidden = YES;
        [self addSubview:self.emptyView];
    }
}

- (UIGeneralEmptyView *)emptyView {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark -
#pragma mark - Event

- (void)calculateDataSource {
    if (!self.emptyView) {
        return;
    }
    if ([self dataSourceCount] == 0) {
        [self showEmptyView];
    } else {
        [self hideEmptyView];
    }
}

- (NSInteger)dataSourceCount {
    NSInteger count = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        for (NSInteger section = 0; section < tableView.numberOfSections; section ++) {
            count += [tableView numberOfRowsInSection:section];
            if (self.emptyView.includeSectionView) {
                CGRect headerRect = [tableView rectForHeaderInSection:section];
                if (headerRect.size.height != 0.f && headerRect.size.width != 0.f) {
                    count += 1;
                }
                CGRect footerRect = [tableView rectForFooterInSection:section];
                if (footerRect.size.height != 0.f && footerRect.size.width != 0.f) {
                    count += 1;
                }
            }
            if (self.emptyView.includeHeaderFooterView) {
                if (tableView.tableHeaderView || tableView.tableFooterView) {
                    count += 1;
                }
            }
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        for (NSInteger section = 0; section < collectionView.numberOfSections; section ++) {
            count += [collectionView numberOfItemsInSection:section];
            if (self.emptyView.includeSectionView && collectionView.contentSize.height != 0) {
                count += 1;
            }
        }
    }
    return count;
}

- (void)showEmptyView {
    self.emptyView.hidden = NO;
    [self bringSubviewToFront:self.emptyView];
}

- (void)hideEmptyView {
    self.emptyView.hidden = YES;
}

- (void)scrollEmptyViewReload {
    if (![self isKindOfClass:[UITableView class]] && ![self isKindOfClass:[UICollectionView class]]) {
        return;
    }
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        [tableView reloadData];
        [tableView stopLoading];
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        [collectionView reloadData];
        [collectionView stopLoading];
    } else {
        [self stopLoading];
    }
}

- (void)startLoading {
    self.emptyView.hidden = YES;
}

- (void)stopLoading {
    if (!self.emptyView) {
        return;
    }
    [self calculateDataSource];
}

@end
