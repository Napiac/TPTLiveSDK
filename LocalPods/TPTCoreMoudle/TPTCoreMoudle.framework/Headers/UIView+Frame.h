//
//  UIView+Frame.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)
@property(nonatomic, assign)CGPoint origin;
@property(nonatomic, assign)CGSize size;


@property(nonatomic)CGFloat centerX;
@property(nonatomic)CGFloat centerY;

@property(nonatomic)CGFloat top;
@property(nonatomic)CGFloat bottom;
@property(nonatomic)CGFloat left;
@property(nonatomic)CGFloat right;

@property(nonatomic)CGFloat x;
@property(nonatomic)CGFloat y;

@property(nonatomic)CGFloat width;
@property(nonatomic)CGFloat height;
@end

NS_ASSUME_NONNULL_END
