//
//  LiveEndMoreLiveModel.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by wansheng on 2022/9/20.
//  直播间 关播页面更多直播 mdeol

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveEndMoreLiveModel : NSObject

@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *place; //位置
@property (nonatomic, copy) NSString *showcover; //封面
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *upload_cover;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *roomnumber;
@property (nonatomic, copy) NSString *viewernum; //观看人数
@property (nonatomic, copy) NSString *gxqm; //签名
@property (nonatomic, copy) NSString *birthday; //生日
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *gender; //0:女 1:男
@property (nonatomic, copy) NSString *usernumber;
@property(nonatomic, assign)BOOL islove; //是否关注
@property(nonatomic, assign)BOOL is_start; //为1是开播，0是未开播
@property (nonatomic, copy) NSString *heat; //热度
 

#pragma mark -
#pragma mark - 封面上的图片
@property (nonatomic, copy) NSString *zx; //周星
@property (nonatomic, copy) NSString *newpeopel; //新人
@property (nonatomic, copy) NSString *goddess; //女神
@property (nonatomic, copy) NSString *startimg; //开播、pk

@end

NS_ASSUME_NONNULL_END
