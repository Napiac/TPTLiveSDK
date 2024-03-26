//
//  TPTUIGeneralShareItem.h
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/13.
//

/// 分享的数据Item
#import <Foundation/Foundation.h>
#import "TPTUIGeneralMoudle.h"

typedef NS_ENUM(NSInteger, ShareEnum) {
    /// 微信朋友圈
    ShareEnum_Wechat,
    /// 微信好友
    ShareEnum_WechatFriend,
    /// QQ好友
    ShareEnum_QQ,
    /// QQ空间
    ShareEnum_QQZone,
};

typedef void(^ShareItemHandler)(void);

NS_ASSUME_NONNULL_BEGIN

@interface TPTUIGeneralShareFormItem : NSObject

@property(nonatomic, assign)ShareEnum shareEnum;
@property(nonatomic, copy)NSString * shareIcon;
@property(nonatomic, copy)NSString * shareTitle;
@property(nonatomic, copy)ShareItemHandler handler;

+ (instancetype)itemWithEnum:(ShareEnum)shareEnum;
@end

NS_ASSUME_NONNULL_END
