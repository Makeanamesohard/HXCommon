

#import <Foundation/Foundation.h>

@interface NSString (MY)

- (BOOL)containString:(NSString *)string;
- (NSString *)trim;

// AES加密
- (NSString *)AESEncodeStringWithKey:(NSString *)key;
- (NSString *)AESDecodeStringWithKey:(NSString *)key;
- (NSString *)AESEncodeString;
- (NSString *)AESDecodeString;

// SHA256
- (NSString *)SHA256String;

- (NSDate *)stringToDate;

- (NSDate *)dateWithFormat:(NSString *)format;


//验证手机号
+(BOOL)checkTelNumber:(NSString*)telNumber;

- (id)objectForKeyedSubscript:(NSString *)key;

+(NSString *)filterString:(NSString *)string;
@end
