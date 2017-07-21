//
//  NSDate+MY.h
//  fitplus
//
//  Created by wanghexiang on 27/6/16.
//  Copyright © 2016年 uiki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HX)
- (NSString *)dateString;
- (NSString *)monthString;
//- (NSInteger)beforeMonth;
//- (NSInteger)afterMonth;
- (NSDate *)beforeMonthDate;
- (NSDate *)afterMonthDate;
- (NSInteger)currentWeek;
- (NSDate *)firstDay;
- (NSDate *)dateWithTimeInterval:(double)interval;
- (NSInteger)year;
- (NSInteger)day;
- (NSInteger)minute;
- (NSInteger)second;
- (NSInteger)hour;
- (NSInteger)month;
+ (NSDate *)beijingTime;
+ (NSCalendar *)GMTCalendar;

- (NSDate *)localTime;

- (NSDate *)aweekAgo;
- (NSDate *)amonthAgo;
- (NSDate *)ayearAgo;
- (NSDate *)adayAgo;
- (NSString *)weekString;

- (NSDate *)beginOfADay;
- (NSDate *)endDay;


- (NSDate *)twentyFourHourLater;

- (NSString *)TZDateString;
- (NSString *)GMTDateString;
- (NSString *)timeString;

- (NSString *)detailString;
@end
