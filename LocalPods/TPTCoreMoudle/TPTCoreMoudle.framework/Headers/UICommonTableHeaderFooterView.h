//
//  UICommonTableHeaderFooterView.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/21.
//  Copyright © 2022 Napiac. All rights reserved.
//

///UITableViewHeaderFooterView基础类
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICommonTableHeaderFooterView : UITableViewHeaderFooterView

+ (instancetype)loadViewWithTableView:(UITableView *)tableView;
+ (instancetype)loadNibViewWithTableView:(UITableView *)tableView
                                     nib:(UINib *)iNib;

@end

NS_ASSUME_NONNULL_END
