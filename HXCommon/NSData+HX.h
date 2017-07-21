

#import <Foundation/Foundation.h>

@interface NSData (HX)

- (NSString *)base64Encoded;
- (NSData *)base64Decoded;

- (NSData *)desEncodeDataWithKey:(NSString *)key;
- (NSData *)desDecodeDataWithKey:(NSString *)key;
- (NSData *)desEncodeData;
- (NSData *)desDecodeData;

- (NSData *)SHA256Hash;



@end
