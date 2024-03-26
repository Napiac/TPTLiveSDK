//
//  TPTViewDebug.h
//  TPTBlackBoxTestingMoudle
//
//  Created by Napiac on 2023/6/12.
//  Copyright © 2023 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPTViewDebug : NSObject

+ (NSArray *)fetchAllViewsDataInHierarchy;

+ (NSData *)snapshotImageData:(UIView *)view isSubviewsExcluding:(BOOL)isSubviewsExcluding clippedFrame:(CGRect)clippedFrame;

@end

NS_ASSUME_NONNULL_END
