//
//  TPTLog.h
//  TPTBlackBoxTestingMoudle
//
//  Created by Napiac on 2023/6/10.
//  Copyright © 2023 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define NSLog(...)          TPTLog(__FUNCTION__, __LINE__, @"AppGeneral", __VA_ARGS__)
#define TPTAppLog(...)      TPTLog(__FUNCTION__, __LINE__, @"AppGeneral", __VA_ARGS__)
#define TPTErrorLog(...)    TPTLog(__FUNCTION__, __LINE__, @"Error", __VA_ARGS__)
#define TPTHTTPLog(...)     TPTLog(__FUNCTION__, __LINE__, @"HTTP", __VA_ARGS__)
#define TPTWSLog(...)       TPTLog(__FUNCTION__, __LINE__, @"WebSocket", __VA_ARGS__)

NS_ASSUME_NONNULL_BEGIN

extern void TPTLog(const char *functionName, int lineNumber, NSString *domain, NSString *format, ...);

NS_ASSUME_NONNULL_END
