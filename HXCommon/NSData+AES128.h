
#import <Foundation/Foundation.h>
@interface NSData (AES128)
- (NSData *)AES128EncryptWithKey:(NSString *)key;
- (NSData *)AES128DecryptWithKey:(NSString *)key;
@end
