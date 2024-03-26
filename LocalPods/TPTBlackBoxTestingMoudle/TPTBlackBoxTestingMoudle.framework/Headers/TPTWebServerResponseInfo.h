//
//  TPTWebServerResponseInfo.h
//  TPTBlackBoxTestingMoudle
//
//  Created by Napiac on 2023/6/12.
//  Copyright © 2023 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPTWebServerResponseInfo : NSObject
@property(nonatomic, strong, nullable)NSData * data;
@property(nonatomic, copy, nullable)NSString * contentType;

@end

NS_ASSUME_NONNULL_END
