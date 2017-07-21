
#import <Foundation/Foundation.h>

@interface HXPath : NSObject

+ (NSString *)documentPath;
+ (NSString *)bundlePath;
+ (NSString *)tempPath;
+ (NSString *)imagePath;
+ (NSString *)headImagePath;

+ (NSString *)globalCachePath;
+ (NSString *)secretCachePath;
+ (NSString *)userPathWithUserId:(NSString *)userId;
+ (NSString *)logUploadPath;
+ (NSString *)consoleLogPath;

@end
