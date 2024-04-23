//
//  UIGeneralEmptyView.h
//  TPTUIGeneralMoudle
//
//  Created by 凡骄 on 2022/8/24.
//

#import "UIGeneralCommonEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIGeneralEmptyView : UIGeneralCommonEmptyView

@property (nonatomic, strong, readonly)UIImageView * emptyImageView; //图片
@property (nonatomic, strong, readonly)UILabel * titleLabel; //标题
@property (nonatomic, strong, readonly)UILabel * contentLabel; //小文字
@property (nonatomic, strong, readonly)UIButton * refreshButton; //刷新按钮

/// NO:Section头部、尾部的时候直接忽略，看dataSource是否有值
/// YES:再有Section头部、尾部的情况是否通过计算来显示空视图 (Default)
@property (nonatomic, assign) BOOL includeSectionView;

/// NO:HeaderView、FooterView直接忽略，看dataSource是否有值
/// YES:再有HeaderView、FooterView的情况是否通过计算来显示空视图 (Default)
@property (nonatomic, assign) BOOL includeHeaderFooterView;

@end

NS_ASSUME_NONNULL_END
