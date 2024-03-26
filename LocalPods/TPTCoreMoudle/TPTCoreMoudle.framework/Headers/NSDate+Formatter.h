//
//  NSDate+Formatter.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Formatter)
+ (NSDateFormatter *)formatter;
+ (NSDateFormatter *)formatterWithoutTime;
+ (NSDateFormatter *)formatterWithoutDate;

- (NSString *)formatWithUTCTimeZone;
- (NSString *)formatWithLocalTimeZone;
- (NSString *)formatWithTimeZoneOffset:(NSTimeInterval)offset;
- (NSString *)formatWithTimeZone:(NSTimeZone *)timezone;

- (NSString *)formatWithUTCTimeZoneWithoutTime;
- (NSString *)formatWithLocalTimeZoneWithoutTime;
- (NSString *)formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset;
- (NSString *)formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone;

- (NSString *)formatWithUTCWithoutDate;
- (NSString *)formatWithLocalTimeWithoutDate;
- (NSString *)formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset;
- (NSString *)formatTimeWithTimeZone:(NSTimeZone *)timezone;


+ (NSString *)currentDateStringWithFormat:(NSString *)format;
+ (NSDate *)dateWithSecondsFromNow:(NSInteger)seconds;
- (NSString *)dateWithFormat:(NSString *)format;
@end

NS_ASSUME_NONNULL_END
