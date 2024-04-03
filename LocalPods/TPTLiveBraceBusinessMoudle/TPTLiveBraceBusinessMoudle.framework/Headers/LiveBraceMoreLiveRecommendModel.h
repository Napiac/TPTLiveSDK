//
//  LiveBraceMoreLiveRecommendModel.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by 田建波 on 2022/9/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveBraceMoreLiveRecommendLogoInfoModel : NSObject

@property (nonatomic, copy) NSString * img;
@property (nonatomic, assign) CGFloat img_width;
@property (nonatomic, assign) CGFloat img_height;

@end

@interface LiveBraceMoreLiveRecommendModel : NSObject

/// 用户id
@property (nonatomic, copy) NSString * user_id;
/// 昵称
@property (nonatomic, copy) NSString * nick_name;
/// 是否开播
@property (nonatomic, copy) NSString * is_showing;
/// 房间号
@property (nonatomic, copy) NSString * user_number;
/// 封面
@property (nonatomic, copy) NSString * show_cover;
/// 热度
@property (nonatomic, copy) NSString * heat;
/// 直播间标题
@property (nonatomic, copy) NSString * show_title;
/// 头像
@property (nonatomic, copy) NSString * head_portrait;
/// 角标
@property(nonatomic, strong)LiveBraceMoreLiveRecommendLogoInfoModel * subscript;

@end




NS_ASSUME_NONNULL_END
