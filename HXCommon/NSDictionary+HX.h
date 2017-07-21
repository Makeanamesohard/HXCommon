

#import "NSDate+HX.h"
#import <Foundation/Foundation.h>

@interface NSDictionary (HX)

- (NSString *)stringForKey:(id)key;
- (BOOL)boolForKey:(id)key;
- (int)intForKey:(id)key;
- (NSInteger)integerForKey:(id)key;
- (uint)uintForKey:(id)key;
- (double)doubleForKey:(id)key;
- (float)floatForKey:(id)key;
- (long long)longLongForKey:(id)key;
- (long)longForKey:(id)key;
- (u_int64_t)ulongLongForKey:(id)key;
- (NSArray *)arrayForKey:(id)key;
- (NSDictionary *)dictionaryForKey:(id)key;

- (id)exitObjectForKey:(id)key;

@end
