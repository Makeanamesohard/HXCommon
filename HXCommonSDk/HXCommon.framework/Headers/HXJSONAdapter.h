
#import <Foundation/Foundation.h>

@interface NSString (HXJSONAdapter)
- (id)jsonValue;
@end

@interface NSData (HXJSONAdapter)
- (id)jsonValue;
@end

@interface NSDictionary (HXJSONAdapter)
- (NSString *)jsonString;
@end

@interface NSArray (HXJSONAdapter)
- (NSString *)jsonString;
@end
