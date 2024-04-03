//
//  LiveBraceMoreAdModel.h
//  TPTLiveBraceMoreAdMoudle
//
//  Created by wangyin on 2022/9/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/// 跳转url
@interface LiveBraceMoreAdModelJumpAddress : NSObject
@property (nonatomic, copy)NSString *ios_url;
@property (nonatomic, copy)NSString *android_url;
@end


/// 跳转参数模型
@interface LiveBraceMoreAdModelJump : NSObject
/// 跳转方式
@property (nonatomic, copy)NSString *open_type;
/// 跳转url
@property (nonatomic, strong)LiveBraceMoreAdModelJumpAddress *jump_address;
@end

/// 广告位显示资源
@interface LiveBraceMoreAdModelResource : NSObject
/// 普通模式图片
@property (nonatomic, copy)NSString *img;
/// 暗黑模式图片
@property (nonatomic, copy)NSString *dark_img;
/// 竖状模式图片
@property (nonatomic, copy)NSString *minimize_img;
/// 视频地址
@property (nonatomic, copy)NSString *video_address;
/// 网页地址
@property (nonatomic, copy)NSString *web_address;

@end


/// 广告显示位置
@interface LiveBraceMoreAdDisplayCoordinate : NSObject
@property (nonatomic, assign)CGFloat ios_top_margin;
@property (nonatomic, assign)CGFloat ios_left_margin;
@property (nonatomic, assign)CGFloat ios_bottom_margin;
@property (nonatomic, assign)CGFloat ios_right_margin;
@end

/// 广告位数据模型
@interface LiveBraceMoreAdModel : NSObject

/// 标题
@property (nonatomic, copy) NSString *title;
/// 广告类型 0图片广告 1视频广告  2网页广告
@property (nonatomic, assign) int type;
/// 跳转配置
@property (nonatomic, strong)LiveBraceMoreAdModelJump *jump_config;
/// 广告位显示资源
@property (nonatomic, strong)LiveBraceMoreAdModelResource *resources;
/// 广告显示位置
@property (nonatomic, strong)LiveBraceMoreAdDisplayCoordinate *coordinate;

#pragma mark-
#pragma mark- costum
///是否是图片
@property (nonatomic, assign, readonly) BOOL isImage;
/// 是否是网页
@property (nonatomic, assign, readonly) BOOL isWeb;
/// 是否是视频
@property (nonatomic, assign, readonly) BOOL isVideo;

@end

NS_ASSUME_NONNULL_END
