//
//  RouteRequestParam.h
//  TPTV2RouterMoudle
//
//  Created by Napiac on 2023/2/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RouteRequestParam : NSObject
@property(nonatomic, copy, nullable)NSString * title;
@property(nonatomic, strong, nullable)NSDictionary * parameters;
@property(nonatomic, strong, nullable)id ext;
@end

NS_ASSUME_NONNULL_END
