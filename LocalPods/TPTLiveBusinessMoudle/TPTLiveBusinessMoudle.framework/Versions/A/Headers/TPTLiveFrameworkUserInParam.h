//
//  TPTLiveFrameworkUserInParam.h
//  TPTLiveBusinessMoudle
//
//  Created by Napiac on 2024/3/20.
//  渠道侧用户登录请求入参

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPTLiveFrameworkUserInParam : NSObject

/// 渠道侧用户唯一标识
@property(nonatomic, copy)NSString * partner_user_id;
@property(nonatomic, copy, nullable)NSString * nick_name;
@property(nonatomic, copy, nullable)NSString * head_img;

/// 性别 0-女 1-男
@property(nonatomic, assign)NSInteger gender;
@end
NS_ASSUME_NONNULL_END
