//
//  LiveEndInfoModel.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by wansheng on 2022/9/19.
//  直播间 主播 关播mdeol

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveEndInfoModel : NSObject

@property (nonatomic, copy) NSString *visitors_num; //观看人数
@property (nonatomic, copy) NSString *fav_num; //新增关注
@property (nonatomic, copy) NSString *vermicelli_num; //粉丝团新增
@property (nonatomic, copy) NSString *click_num; //新增点赞
@property (nonatomic, copy) NSString *point; //获得魅力值
@property (nonatomic, copy) NSString *gift_num; //送礼人数

+ (NSArray *)setAnchorEndLiveDetailsModel:(LiveEndInfoModel *)model;

@end


@interface AnchorEndLiveDetailModel : NSObject

@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@end


NS_ASSUME_NONNULL_END
