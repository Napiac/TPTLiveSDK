//
//  LocationManager.h
//  TPTManagerMoudle
//
//  Created by wansheng on 2022/12/23.
//  定位服务

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

///定位成功
///@param province 省、city 城市、address 具体地址、coordinate 经纬度(latitude - 纬度、longitude - 经度)
typedef void(^LocationSuccess)(NSString * _Nullable province,
                               NSString * _Nullable city,
                               NSString * _Nullable address,
                               CLLocationCoordinate2D coordinate);
///定位失败、授权失败
///@param status 授权状态、desc 失败描述
typedef void(^LocationFailed)(CLAuthorizationStatus status,
                              NSString * _Nullable desc);

NS_ASSUME_NONNULL_BEGIN

@interface LocationManager : NSObject

///定位授权权限
@property (nonatomic, readonly) CLAuthorizationStatus authorizationStatus;


+ (instancetype)shared;
+ (void)destroy;
- (void)startLocationWithSuccess:(LocationSuccess)success
                          failed:(LocationFailed)failed;

@end

NS_ASSUME_NONNULL_END
