//
//  UIColor+Color.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Color)

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)randomColor;

- (NSString *)hexColorString;
@end

NS_ASSUME_NONNULL_END
