//
//  ConfigureConst.h
//  Pods
//
//  Created by Napiac on 2022/11/21.
//

#ifndef ConfigureConst_h
#define ConfigureConst_h

/// HTTP环境
typedef NS_ENUM(NSUInteger, HTTPEnvironment) {
    /// 生产环境(Default)
    HTTPEnvironment_Release = 1001,
    /// 灰度
    HTTPEnvironment_PreRelease,
    /// 测试环境
    HTTPEnvironment_Debug,
    /// 开发环境
    HTTPEnvironment_Develop,
};

/// Host来源
typedef NS_ENUM(NSUInteger, HostSource) {
    /// 3y默认
    HostSource_Default,
    /// 数据中心
    HostSource_DataCenter,
    /// 新数据源
    HostSource_New3Y,
};

#endif /* ConfigureConst_h */
