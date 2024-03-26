//
//  UILabel+Style.m
//  TPTCoreMoudle
//
//  Created by wangyin on 2022/8/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Style)

/// 设置行间距
@property(nonatomic,assign)CGFloat lineSpace;


/// 是否需要自动配置一个行高 默认为NO
/// 设置为yes时会自动计算一个合适的行高
@property(nonatomic,assign)BOOL needAutoLineSpace;

@end

NS_ASSUME_NONNULL_END
