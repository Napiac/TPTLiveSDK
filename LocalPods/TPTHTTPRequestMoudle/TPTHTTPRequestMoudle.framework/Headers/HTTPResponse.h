//
//  HTTPResponse.h
//  HTTPRequest
//
//  Created by Napiac on 2022/7/19.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTTPResponse : NSObject
@property(nonatomic, assign)NSInteger code;
@property(nonatomic, copy, nullable)NSString * message;
@property(nonatomic, strong, nullable)id response;

+ (HTTPResponse *)response;

+ (HTTPResponse *)responseWithParams:(NSDictionary *)params;

+ (HTTPResponse *)responseCode:(NSInteger)code
                       message:(NSString * __nullable)message
                      response:(id __nullable)response;


- (NSData *)responseData;

- (BOOL)tryDecryptData;

@end

NS_ASSUME_NONNULL_END
