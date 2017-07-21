//
//  NSDate+MY.m
//  fitplus
//
//  Created by wanghexiang on 27/6/16.
//  Copyright © 2016年 uiki. All rights reserved.
//

#import "NSDate+HX.h"

@implementation NSDate (HX)
- (NSInteger)year
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    return [calendar component:NSCalendarUnitYear fromDate:self];
}
- (NSInteger)month
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    return [calendar component:NSCalendarUnitMonth fromDate:self];
}

- (NSInteger)hour
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSInteger currentDay  = [calendar component:NSCalendarUnitHour fromDate:self];
    return currentDay;
}

- (NSInteger)minute
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSInteger currentDay  = [calendar component:NSCalendarUnitMinute fromDate:self];
    return currentDay;
}
- (NSInteger)second
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSInteger currentDay  = [calendar component:NSCalendarUnitSecond fromDate:self];
    return currentDay;
}

- (NSInteger)day
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSInteger currentDay  = [calendar component:NSCalendarUnitDay fromDate:self];
    return currentDay;
}
- (NSString *)monthString
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSInteger month  = [calendar component:NSCalendarUnitMonth fromDate:self];
    return [self monthStringFromValue:month];
}


- (NSDate *)beforeMonthDate
{
    
     NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *date = [calendar dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:self options:0];
    return date;
    
}
- (NSDate *)afterMonthDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *date = [calendar dateByAddingUnit:NSCalendarUnitMonth value:+1 toDate:self options:0];
    return date;
}

- (NSInteger)currentWeek
{
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSInteger weekDay  = [calendar component:NSCalendarUnitWeekday fromDate:self];
    return weekDay;
}
- (NSString *)weekString
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [calendar setFirstWeekday:1];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSInteger weekDay  = [calendar component:NSCalendarUnitWeekday fromDate:self];
    if(weekDay==1)
    {
        return NSLocalizedString(@"week_01", nil);
    }else if(weekDay ==2)
    {
        return NSLocalizedString(@"week_02", nil);
    }else if(weekDay ==3)
    {
        return NSLocalizedString(@"week_03", nil);
    }else if(weekDay ==4)
    {
        return NSLocalizedString(@"week_04", nil);
    }else if(weekDay ==5)
    {
        return NSLocalizedString(@"week_05", nil);
    }else if(weekDay ==6)
    {
        return NSLocalizedString(@"week_06", nil);
    }else if(weekDay ==7)
    {
        return NSLocalizedString(@"week_07", nil);
    }else
    {
       return @"";
    }
}


- (NSDate *)firstDay
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.year = [calendar component:NSCalendarUnitYear fromDate:self];
    dateComponents.month = [calendar component:NSCalendarUnitMonth fromDate:self];
    dateComponents.day = 1;
    NSDate *date = [calendar dateFromComponents:dateComponents];
    return date;
}

- (NSDate *)dateWithTimeInterval:(double)interval
{
    double oldDate = self.timeIntervalSince1970;
    double newDate = oldDate+interval;
    return [[NSDate alloc]initWithTimeIntervalSince1970:newDate];
}

- (NSString *)monthStringFromValue:(NSInteger)month
{
    if(month ==1)
    {
        return @"January";
    }else if(month ==2)
    {
        return @"February";
    }else if(month ==3)
    {
        return @"March";
    }else if(month ==4)
    {
        return @"April";
    }else if(month ==5)
    {
        return @"May";
    }else if(month == 6)
    {
        return @"June";
    }else if(month ==7)
    {
        return @"July";
    }else if(month == 8)
    {
        return @"August";
    }else if(month == 9)
    {
        return @"September";
    }else if(month ==10)
    {
        return @"October";
    }else if(month == 11)
    {
        return @"November";
    }else if(month == 12)
    {
        return @"December";
    }else
    {
        return @"";
    }
}

- (NSDate *)localTime
{
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:self];
    return destinationDateNow;
}

+ (NSDate *)beijingTime;
{
    NSDate *dateNow = [NSDate date];
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:dateNow];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:dateNow];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:dateNow];
    return destinationDateNow;
}

- (NSString *)dateString
{
    if([self isEqual:[[[NSDate date] beginOfADay] adayAgo]])
    {
        return NSLocalizedString(@"yestoday", nil);
    }else if(self.year == [NSDate date].year && self.month == [NSDate date].month&&self.day == [NSDate date].day)
    {
        return NSLocalizedString(@"today", nil);
    }else
    {
        return [NSString stringWithFormat:@"%@,%ld%@%ld%@%ld%@",self.weekString,(long)self.year,NSLocalizedString(@"year", nil),(long)self.month,NSLocalizedString(@"month", nil),(long)self.day,NSLocalizedString(@"day", nil)];
    }
}
- (NSString *)timeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm"];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    return [dateFormatter stringFromDate:self];
}

+ (NSCalendar *)GMTCalendar
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone localTimeZone];
    return calendar;
}

- (NSDate *)aweekAgo
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *dateComponent = [[NSDateComponents alloc]init];
    dateComponent.year = self.year;
    dateComponent.month = self.month;
    dateComponent.day = self.day-(self.currentWeek-1);
    dateComponent.hour = 0;
    dateComponent.minute = 0;
    dateComponent.second = 0;
    return [calendar dateFromComponents:dateComponent];
}
- (NSDate *)ayearAgo
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [calendar dateByAddingUnit:NSCalendarUnitYear value:-1 toDate:self options:0];
}

- (NSDate *)amonthAgo
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [calendar dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:self options:0];
}

- (NSDate *)adayAgo
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *dateComponets = [[NSDateComponents alloc]init];
    dateComponets.year = self.year;
    dateComponets.month = self.month;
    dateComponets.day = self.day;
    dateComponets.hour = 0;
    dateComponets.minute = 0;
    dateComponets.second = 0;
    return [calendar dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:[calendar dateFromComponents:dateComponets] options:0];
}
- (NSDate *)beginOfADay
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *dateComponets = [[NSDateComponents alloc]init];
    dateComponets.year = self.year;
    dateComponets.month = self.month;
    dateComponets.day = self.day;
    dateComponets.hour = 0;
    dateComponets.minute = 0;
    dateComponets.second = 0;
    return [calendar dateFromComponents:dateComponets];
}

- (NSDate *)endDay
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *dateComponets = [[NSDateComponents alloc]init];
    dateComponets.year = self.year;
    dateComponets.month = self.month;
    dateComponets.day = self.day;
    dateComponets.hour = 0;
    dateComponets.minute = 0;
    dateComponets.second = 0;
    return [calendar dateByAddingUnit:NSCalendarUnitDay value:+1 toDate:[calendar dateFromComponents:dateComponets] options:0];
}
- (NSDate *)twentyFourHourLater
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [calendar dateByAddingUnit:NSCalendarUnitHour value:23 toDate:self options:0];
}

- (NSString *)TZDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)GMTDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss "];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)detailString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    NSString *fotmatter = [NSString stringWithFormat:@"yyyy%@MM%@dd%@ %@",NSLocalizedString(@"year", nil),NSLocalizedString(@"month", nil),NSLocalizedString(@"day", nil),[self weekString]];
    [dateFormatter setDateFormat:fotmatter];
    return [dateFormatter stringFromDate:self];
}
@end
