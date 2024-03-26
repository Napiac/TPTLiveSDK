//
//  URLModel.h
//  TPTManagerMoudle
//
//  Created by wangyin on 2022/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface URLDetail : NSObject
@property(nonatomic, copy)NSString * title;
@property(nonatomic, copy)NSString * key;
@property(nonatomic, copy)NSString * test;
@property(nonatomic, copy)NSString * text;
@end



@interface URLConfig : NSObject

/// URL配置数组
@property (nonatomic, strong)NSArray <URLDetail *>*list;


/// 获取URL
/// - Parameter key: key
- (URLDetail *)urlForKey:(NSString *)key;


/// 在线客服
@property(nonatomic, strong, readonly)URLDetail * adminsay;

@property(nonatomic, strong, readonly)URLDetail * search;
@property(nonatomic, strong, readonly)URLDetail * myshow;
///个人中心 设置 贵族
@property(nonatomic, strong, readonly)URLDetail * guizu;
/// 开通贵族
@property(nonatomic, strong, readonly)URLDetail * guizhu;
/// 等级体系 等级说明
@property(nonatomic, strong, readonly)URLDetail * levelDetails;


///个人中心 设置 装扮商城
@property(nonatomic, strong, readonly)URLDetail * dress_shop;
@property(nonatomic, strong, readonly)URLDetail * shouyi;
@property(nonatomic, strong, readonly)URLDetail * paytest;
/**钱包服务协议*/
@property(nonatomic, strong, readonly)URLDetail * walletext;
@property(nonatomic, strong, readonly)URLDetail * privacy;
@property(nonatomic, strong, readonly)URLDetail * tcverify;
///主播开播协议
@property(nonatomic, strong, readonly)URLDetail * zhubo;

@property(nonatomic, strong, readonly)URLDetail * regist;
@property(nonatomic, strong, readonly)URLDetail * yaoqing;
@property(nonatomic, strong, readonly)URLDetail * guard;
@property(nonatomic, strong, readonly)URLDetail * msg;
@property(nonatomic, strong, readonly)URLDetail * zbfxurl;
@property(nonatomic, strong, readonly)URLDetail * tgurl;
@property(nonatomic, strong, readonly)URLDetail * returnurl;
@property(nonatomic, strong, readonly)URLDetail * aboutus;
@property(nonatomic, strong, readonly)URLDetail * helpurl;
@property(nonatomic, strong, readonly)URLDetail * fuwu;
@property(nonatomic, strong, readonly)URLDetail * turntable;
@property(nonatomic, strong, readonly)URLDetail * fanmsg;
///zb用户协议
@property(nonatomic, strong, readonly)URLDetail * usermsg;
@property(nonatomic, strong, readonly)URLDetail * norm;

/// 天外物舱入口地址
@property(nonatomic, strong, readonly)URLDetail * TianwaiWarehouse;
///赛季榜单h5
@property(nonatomic, strong, readonly)URLDetail * pk_new_season_url;
/// 头条指数榜单
@property(nonatomic, strong, readonly)URLDetail * top_point_url;

///隔空pk详情h5
@property(nonatomic, strong, readonly)URLDetail * septumPkExplain;

///直播间扶持入口地址
@property(nonatomic, strong, readonly)URLDetail * live_support;

///活动中心入口地址
@property(nonatomic, strong, readonly)URLDetail * activity_center;

/// 企业认证h5
@property(nonatomic, strong, readonly)URLDetail * businessApply;
/// 达人认证h5
@property(nonatomic, strong, readonly)URLDetail * talentApply;
/// 认证中心
@property(nonatomic, strong, readonly)URLDetail * authenCenter;

/// 小时榜单介绍
@property(nonatomic, strong, readonly)URLDetail * hourListDesc;

/// 红包规则
@property(nonatomic, strong, readonly)URLDetail * redPacketRule;

/// 礼物展馆规则
@property(nonatomic, strong, readonly)URLDetail * giftGallery;

///语聊协议
@property(nonatomic, strong, readonly)URLDetail * voice_chat;

/// 火bei(助上热门)链接地址
@property(nonatomic, strong, readonly)URLDetail * fire_bei;

/// 主播底薪说明说明URL
@property(nonatomic, strong, readonly)URLDetail * basePaySay;

/// h5VIP
@property(nonatomic, strong, readonly)URLDetail * vip_center;

/// vip服务协议
@property(nonatomic, strong, readonly)URLDetail * vip_service_agreement;

@end

NS_ASSUME_NONNULL_END
