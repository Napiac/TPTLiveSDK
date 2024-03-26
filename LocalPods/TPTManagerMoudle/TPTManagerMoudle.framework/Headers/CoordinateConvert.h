//
//  CoordinateConvert.h
//  TPTManagerMoudle
//
//  Created by wansheng on 2022/12/23.
//  定位经纬度坐标转化

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoordinateConvert : NSObject

/// 地球坐标转换为火星坐标
/// @param location 地球坐标
/// @return 返回转换后的火星坐标
+ (CLLocation *)transformToMars:(CLLocation *)location;

@end

NS_ASSUME_NONNULL_END
