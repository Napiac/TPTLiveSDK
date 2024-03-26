//
//  UICommonWebViewController.h
//  TPTCoreMoudle
//
//  Created by 田建波 on 2022/9/20.
//


//控制器形式的浏览器
#import "UICommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICommonWebViewController : UICommonViewController

///网页链接地址
@property(nonatomic, copy)NSString * webURLString;

- (instancetype)initWithURLString:(NSString * _Nullable)URLString;

@end

NS_ASSUME_NONNULL_END
