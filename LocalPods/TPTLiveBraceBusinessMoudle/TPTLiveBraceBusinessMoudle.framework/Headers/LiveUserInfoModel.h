//
//  LiveUserInfoModel.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by wansheng on 2022/10/8.
//  直播间 用户信息model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveUserInfoModel : NSObject

@property (nonatomic, copy) NSString *showId;
@property (nonatomic, copy) NSString *liveRoomOwnerId; //直播间 主播的userid
@property (nonatomic, assign) BOOL isMine; //是否是账号登录者自己的用户信息
@property (nonatomic, assign) BOOL isLoginState; //YES:登录中.. NO:未登录
@property (nonatomic, copy) NSString *shell; //用户贝壳的数量
@property (nonatomic, copy) NSString *balance; //app币数量
@property (nonatomic, copy) NSString *pearl;
@property (nonatomic, copy) NSString *username; //用户帐号

@property (nonatomic, assign) BOOL is_vip; //是否是vip
@property (nonatomic, assign) BOOL is_the_experience; //
@property (nonatomic, copy) NSString *vip_image; //vip图标
@property (nonatomic, copy) NSString *network_vip_img; //vip图标

@property (nonatomic, copy) NSString *userid; //用户id
@property (nonatomic, copy) NSString *showUserid;
@property (nonatomic, copy) NSString *user_number; //靓号
@property (nonatomic, copy) NSString *isachor; //是否是主播 0:用户 1:线上主播 2:线下主播
@property (nonatomic, assign) NSInteger applysign_pass; //主播认证 0:没去认证 1:未通过 2:审核中 3:通过主播认证
@property (nonatomic, assign) BOOL whetherToFocusOn; //主播对用户是否关注   0：未关注，1：已关注

@property (nonatomic, copy) NSString *is_family; //家族ID
@property (nonatomic, copy) NSString *fans_group_status; //主播创建粉丝群状态  0 待审核  有粉丝群就是给的粉丝群 id       2被拒绝 3未创建
@property (nonatomic, assign) BOOL is_fansBrand; // A查看B个人信息，需要知道A是不是B的粉丝 1 是 0不是
@property (nonatomic, copy) NSString *joinFansPrice; //加入粉丝团金额
@property(nonatomic, copy) NSString *giftimage; //卡片顶框图
@property(nonatomic, assign) NSInteger gui_grade; //贵族等级  0为没有贵族 1-6 侠士到皇帝

@property (nonatomic, copy) NSString *show_cover; //直播间封面图
@property (nonatomic, copy) NSString *head_portrait; //头像
@property (nonatomic, copy) NSString *head_portrait_box; //头像框
@property (nonatomic, assign) BOOL avatar_violation; //头像是否违规
@property (nonatomic, copy) NSString *nick_name; //昵称
@property (nonatomic, copy) NSString *gender; //性别
@property (nonatomic, copy) NSString *age; //年龄
@property (nonatomic, copy) NSString *level; //
@property (nonatomic, copy) NSString *levelstr; //
@property (nonatomic, copy) NSString *network_level; //活跃等级小图标

@property (nonatomic, copy) NSString *pointlevel;//主播等级
@property (nonatomic, copy) NSString *network_pointlevel; //主播等级图片
@property (nonatomic, copy) NSString *network_pointlevel_big;//主播等级图片  新
@property (nonatomic, copy) NSString *guizhu; //贵族等级
@property (nonatomic, copy) NSString *guizhu_explain; //贵族等级
@property (nonatomic, copy) NSString *network_guizhu; //贵族图片
@property (nonatomic, copy) NSString *network_guard; //守护的图片
@property (nonatomic, copy) NSString *gxqm; //个性签名

@property (nonatomic, copy) NSString *birthday; //生日
@property (nonatomic, copy) NSString *emotion; //情感状态
@property (nonatomic, copy) NSString *job; //职业
@property (nonatomic, copy) NSString *province; //地区
@property (nonatomic, copy) NSString *industry; //行业
@property (nonatomic, copy) NSString *love_num; //关注数
@property (nonatomic, copy) NSString *bei_love_num; //被关注数
@property (nonatomic, copy) NSString *love_fans_number; //真爱粉
@property (nonatomic, copy) NSString *follow_me_num; //我关注的数量
@property (nonatomic, copy) NSString *fan_num; //粉丝数
@property (nonatomic, copy) NSString *heat; //魅力值
@property (nonatomic, copy) NSString *token; //

@property (nonatomic, copy) NSString *mobile; //手机号
@property (nonatomic, copy) NSString *weixin_nickname; //微信昵称

@property (nonatomic, copy) NSString *season_name; //段位相关：段位名、
@property (nonatomic, copy) NSString *season_level; //段位等级
@property (nonatomic, copy) NSString *network_season_level; //段位网图

@property (nonatomic, copy) NSString *wealth_level_name; //财富等级名字
@property (nonatomic, copy) NSString *wealth_level_number; //财富登记 number
@property (nonatomic, copy) NSString *wealth_level; //财富等级
@property (nonatomic, copy) NSString *network_wealth_level_img; //财富等级图片
@property (nonatomic, copy) NSString *wealthImg; //财富等级图片
@property  (nonatomic, copy) NSString *activeImg; //活跃等级图片
@property (nonatomic, copy) NSString *user_level; //活跃等级
@property (nonatomic, copy) NSString *user_level_name; //活跃等级名字

@property (nonatomic, copy) NSString *wealth_level_img;//财富等级本地图片
@property (nonatomic, copy) NSString *city;//城市
@property (nonatomic, copy) NSString *anchor_level;//主播等级

@property (nonatomic, copy) NSString *app_open; //打开方式
@property (nonatomic, copy) NSString *url; //分享链接
@property (nonatomic, assign) BOOL userstatus; //YES:用户注销

@property (nonatomic, assign) BOOL isshow; //查看别人的个人信息 是否正在直播
@property (nonatomic, assign) BOOL is_follow; //查看别人的个人信息 是否关注

@property (nonatomic, copy) NSString *play_count; //播放量

///
@property (nonatomic, copy) NSString *sexAge; //年龄 +性别
@property (nonatomic, copy) NSString *cityDetail; //省 +城市
@property (nonatomic, copy) NSString *countString; // 关注 + 播放量
@property (nonatomic, copy) NSString *watchCount; //观看人数

@end

NS_ASSUME_NONNULL_END
