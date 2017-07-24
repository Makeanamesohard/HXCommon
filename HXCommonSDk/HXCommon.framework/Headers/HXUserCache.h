
#import <Foundation/Foundation.h>

#define UID @"userid"

@interface HXUserCache : NSObject

+ (instancetype)shareCache;

- (void)setUser:(NSString *)userId;

// 通用配置
- (void)setObject:(id)obj forKey:(NSString *)key;
- (void)setString:(NSString *)string forKey:(NSString *)key;
- (void)setInt:(int)number forKey:(NSString *)key;
- (void)setLongLong:(long long)number forKey:(NSString *)key;
- (void)setFloat:(float)number forKey:(NSString *)key;
- (void)setDouble:(double)number forKey:(NSString *)key;
- (void)setBool:(BOOL)number forKey:(NSString *)key;

- (id)objectForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (NSMutableDictionary *)mutableDictionaryForKey:(NSString *)key;
- (int)intForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;
- (uint)uintForKey:(id)key;
- (long long)longLongForKey:(NSString *)key;
- (u_int64_t)ulongLongForKey:(id)key;
- (float)floatForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;

//  加密配置
- (void)setSecretString:(NSString *)string forKey:(NSString *)key;
- (void)setSecretInt:(int)number forKey:(NSString *)key;
- (void)setSecretFloat:(float)number forKey:(NSString *)key;
- (void)setSecretDouble:(double)number forKey:(NSString *)key;

- (NSString *)secretStringForKey:(NSString *)key;
- (int)secretIntForKey:(NSString *)key;
- (float)secretFloatForKey:(NSString *)key;
- (double)secretDoubleForKey:(NSString *)key;

- (void)synchronize;



@end
