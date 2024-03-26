//
//  UIView+DisplayNetworkError.h
//  TPTCoreMoudle
//
//  Created by dfb on 2022/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NetworkErrorConfig;
@protocol NetworkErrorOnViewProtocol <NSObject>

@optional;

/// 显示无网络占位图
/// @param hander 点击按钮回调
- (void)showHander:(void(^)(void))hander;

///
- (void)showNetworkErrorWithConfig:(NetworkErrorConfig * _Nullable)config
                            Hander:(void (^)(void))hander;
///
- (void)removeNetworkError;

@end




@interface UIView (DisplayNetworkError)<NetworkErrorOnViewProtocol>

@end



@interface NetworkErrorConfig : NSObject
@property (nonatomic, strong)UIColor *butttonBgColor;
///整体View y轴偏移
@property (nonatomic, assign) CGFloat offsetY;
///图片内容 y轴偏移 默认 40
@property (nonatomic, assign) CGFloat imageOffsetY;
///
@property (nonatomic) CGRect frame;
///标题
@property (nonatomic, copy) NSString *title;
///图片
@property (nonatomic, strong) UIImage *image;
///二级标题
@property (nonatomic, copy) NSString *subTitle;
///背景色
@property (nonatomic, copy) NSString *bgColor;

@end

NS_ASSUME_NONNULL_END


