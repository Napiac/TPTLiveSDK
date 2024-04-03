//
//  LiveGiftRecordModel.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by wansheng on 2022/10/13.
//  本场收礼记录Model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveGiftRecordModel : NSObject

///魅力值
@property (nonatomic, copy) NSString *point;
///送礼人昵称
@property (nonatomic, copy) NSString *nick_name;
///数量
@property (nonatomic, copy) NSString *number;
///礼物名称
@property (nonatomic, copy) NSString *giftname;
///礼物图片
@property (nonatomic, copy) NSString *giftimage;

#pragma mark-
#pragma mark- custom
///显示的收到礼物名称
@property (nonatomic, copy) NSString *showGiftName;

@end

NS_ASSUME_NONNULL_END
