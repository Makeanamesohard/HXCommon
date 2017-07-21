

#import "HXPath.h"

@implementation HXPath

+ (NSString *)documentPath {
    static NSString *documentPath;
    if (!documentPath) {
        NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentPath = [[searchPaths objectAtIndex:0] copy];
    }
    return documentPath;
}

+ (NSString *)bundlePath {
    return [[NSBundle mainBundle] resourcePath];
}

+ (NSString *)tempPath {
    
    static NSString *tempPath;
    if (!tempPath) {
        tempPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] copy];
    }
    return tempPath;
}

+ (NSString *)imagePath
{
    static NSString *imagePath;
    if(!imagePath)
    {
        imagePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/image"] copy];
        if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:NULL error:NULL];
        }

    }
    return imagePath;
}

+ (NSString *)headImagePath
{
    static NSString *headImagePath;
    if(!headImagePath)
    {
        headImagePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/headImage"] copy];
        if (![[NSFileManager defaultManager] fileExistsAtPath:headImagePath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:headImagePath withIntermediateDirectories:YES attributes:NULL error:NULL];
        }
    }
    return headImagePath;

}

+ (NSString *)globalCachePath {
    static NSString *globalCachePath;
    if (!globalCachePath) {
        globalCachePath = [[[HXPath documentPath] stringByAppendingPathComponent:@"global.plist"] copy];
    }
    return globalCachePath;
}

+ (NSString *)secretCachePath {
    
    static NSString *secretCachePath;
    if (!secretCachePath) {
        secretCachePath = [[[HXPath documentPath] stringByAppendingPathComponent:@"secret.plist"] copy];
    }
    return secretCachePath;
}

+ (NSString *)userPathWithUserId:(NSString *)userId {
    return [NSString stringWithFormat:@"%@/%@",[HXPath documentPath],userId];
}

+ (NSString *)logUploadPath {
    static NSString *logPath;
    if (!logPath) {
        logPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/LogUpload"] copy];
        if (![[NSFileManager defaultManager] fileExistsAtPath:logPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:logPath withIntermediateDirectories:YES attributes:NULL error:NULL];
        }
    }
    return logPath;
}

+ (NSString *)consoleLogPath {
    
    static NSString *consoleLogPath;
    if (!consoleLogPath) {
        consoleLogPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Log/console"] copy];
    }
    return consoleLogPath;
}

@end
