//
//  NSObject+AppInfo.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>

__attribute__((deprecated("This enum type is deprecated. Please use a TPTCoreAPPSourceDefine Class.")))
typedef NS_ENUM(NSInteger, APPType) {
    APPType_Unknown = -1,
    APPType_BeiWorld = 101,
    APPType_BeiBei = 102,
    APPType_BeiLiveHelper = 103,
    APPType_Free = 101,
    APPType_Plus = 102,
};

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AppInfo)
- (NSString *)tpt_version;
- (NSString *)tpt_build;
- (NSString *)tpt_identifier;
- (NSString *)tpt_currentLanguage;
- (NSString *)tpt_deviceModel;
- (NSString *)tpt_name;
- (UIImage *)tpt_logo;

- (APPType)appType;

@end

NS_ASSUME_NONNULL_END
