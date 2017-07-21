//
//  NSString+DV.m
//  Devond
//
//  Created by Devond on 14/11/22.
//  Copyright (c) 2014年 Horace. All rights reserved.
//

#import "NSString+HX.h"
#import "NSData+AES128.h"
#import "NSData+Base64.h"
#import "NSData+HX.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

static NSString *DevondDesDefaultKey = @"DevondIsAmazing";

@implementation NSString (MY)

- (BOOL)containString:(NSString *)string {
    if (!string || string.length <= 0) {
        return NO;
    }
    return ([self rangeOfString:string].location != NSNotFound);
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)AESEncodeString {
    return [self AESEncodeStringWithKey:DevondDesDefaultKey];
}

- (NSString *)AESDecodeString {
    return [self AESDecodeStringWithKey:DevondDesDefaultKey];
}

- (NSString *)AESEncodeStringWithKey:(NSString *)key {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *sha256Key = [key SHA256String];
    NSData *encodeData = [data AES128EncryptWithKey:sha256Key];
    return [encodeData base64Encoded];
}

- (NSString *)AESDecodeStringWithKey:(NSString *)key {
    NSData *data = [[self dataUsingEncoding:NSUTF8StringEncoding] base64Decoded];
    NSString *sha256Key = [key SHA256String];
    NSData *decodeData = [data AES128DecryptWithKey:sha256Key];
    return [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
}

- (NSString *)SHA256String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char hash[CC_SHA256_DIGEST_LENGTH];
    (void) CC_SHA256( [data bytes], (CC_LONG)[data length], hash );
    return [[NSString alloc] initWithBytes:hash length:CC_SHA256_DIGEST_LENGTH encoding:NSUTF8StringEncoding];
}

- (NSDate *)stringToDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss +zzzz"];
    NSDate *destDate= [dateFormatter dateFromString:self];
    return destDate;
}

- (NSDate *)dateWithFormat:(NSString *)format {
	if (format.length == 0) {
		return nil;
	}
	
	static NSDateFormatter *formatter;
    static dispatch_once_t once;
	dispatch_once(&once, ^{
        formatter = [[NSDateFormatter alloc] init];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [formatter setCalendar:calendar];
    });
	[formatter setDateFormat:format];
	NSDate *date = [formatter dateFromString:self];
	return date;
}


//是否是手机号码
+(BOOL)checkTelNumber:(NSString*)telNumber
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:telNumber];
    BOOL res2 = [regextestcm evaluateWithObject:telNumber];
    BOOL res3 = [regextestcu evaluateWithObject:telNumber];
    BOOL res4 = [regextestct evaluateWithObject:telNumber];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

- (id)objectForKeyedSubscript:(NSString *)key
{
    NSLog(@"");
    return nil;
}

+(NSString *)filterString:(NSString *)string
{
    NSString *str = [string substringWithRange:NSMakeRange(string.length%3, string.length-string.length%3)];
    NSString *strs = [string substringWithRange:NSMakeRange(0, string.length%3)];
    for (int  i =0; i < str.length; i =i+3) {
        NSString *sss = [str substringWithRange:NSMakeRange(i, 3)];
        strs = [strs stringByAppendingString:[NSString stringWithFormat:@",%@",sss]];
    }
    if ([[strs substringWithRange:NSMakeRange(0, 1)] isEqualToString:@","]) {
        strs = [strs substringWithRange:NSMakeRange(1, strs.length-1)];
    }
    return strs;
}
@end
