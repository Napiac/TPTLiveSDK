//
//  TPTWebServerMiddleware.h
//  TPTBlackBoxTestingMoudle
//
//  Created by Napiac on 2023/6/10.
//  Copyright © 2023 Napiac. All rights reserved.
//  中间件

typedef void (^ReadLogBlock) (NSString * log);
@class TPTWebServerResponseInfo;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPTWebServerMiddleware : NSObject



+ (void)inputLog:(NSString *)log;
+ (void)redirectStandardOutputLog:(ReadLogBlock)handler;


+ (NSDictionary *)fetchDatabaseAPITemplateHTMLReplacement:(NSDictionary *)params;

+ (TPTWebServerResponseInfo *)fetchDatabaseAPIResponseInfo:(NSDictionary *)params;
+ (TPTWebServerResponseInfo *)fetchViewDebugAPIResponseInfo:(NSDictionary *)params;

+ (TPTWebServerResponseInfo *)fetchFileExplorerAPIResponseInfo:(NSDictionary *)params;
+ (TPTWebServerResponseInfo *)uploadTemporaryFile:(NSString *)temporaryPath
                                  targetDirectory:(NSString *)targetDirectory
                                         fileName:(NSString *)targetFileName;

+ (TPTWebServerResponseInfo *)fetchFilePreviewResponseInfo:(NSDictionary *)param;


+ (NSString *)formatTemplateString:(NSString *)str
                         variables:(NSDictionary *)variables;
@end

NS_ASSUME_NONNULL_END
