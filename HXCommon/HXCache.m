//
//  HTCache.m
//  
//
//  Created by zhuzhi on 13-7-19.
//  Copyright (c) 2013年 HT. All rights reserved.
//

#import "HXCache.h"
#import "HXPath.h"
#import "NSDictionary+HX.h"
#import "NSString+HX.h"


@interface HXCache () {
    NSRecursiveLock *cacheLock;
    dispatch_queue_t queue;
}

@property (nonatomic,copy) NSString *globalPath;
@property (nonatomic,copy) NSString *secretPath;

@property (atomic,strong) NSMutableDictionary *globalDict;
@property (atomic,strong) NSMutableDictionary *secretDict;


@end

@implementation HXCache

+(instancetype)sharedCache
{
    static HXCache *cache = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        cache = [[self alloc]init];
    });
    return cache;
}

- (id)init {
    self = [super init];
    if (self) {
        cacheLock = [[NSRecursiveLock alloc] init];
        queue = dispatch_queue_create("CacheQueue", DISPATCH_QUEUE_SERIAL);
        [self initCache];
        
    }
    return self;
}

- (void)initCache {
    
    [cacheLock lock];
    
    NSString *globalPath = [HXPath globalCachePath];
    self.globalPath = globalPath;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:globalPath]) {
        self.globalDict = [NSMutableDictionary dictionaryWithContentsOfFile:globalPath];
    } else {
        self.globalDict = [NSMutableDictionary dictionary];
    }
    
    NSString *secretPath = [HXPath secretCachePath];
    self.secretPath = secretPath;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:secretPath]) {
        self.secretDict = [NSMutableDictionary dictionaryWithContentsOfFile:secretPath];
    } else {
        self.secretDict = [NSMutableDictionary dictionary];
    }
    
    [cacheLock unlock];
}

- (void)setObject:(id)object forKey:(NSString *)key {
    if (object && key && ![object isKindOfClass:[NSNull class]]) {
        [cacheLock lock];
        [self.globalDict setObject:object forKey:key];
        [cacheLock unlock];
    }
}

- (void)setString:(NSString *)string forKey:(NSString *)key {
    [self setObject:string forKey:key];
}

- (void)setInt:(int)number forKey:(NSString *)key {
    [self setObject:[NSNumber numberWithInt:number] forKey:key];
}

- (void)setLong:(long)number forKey:(NSString *)key {
    [self setObject:[NSNumber numberWithLong:number] forKey:key];
}

- (void)setFloat:(float)number forKey:(NSString *)key {
    [self setObject:[NSNumber numberWithFloat:number] forKey:key];
}

- (void)setDouble:(double)number forKey:(NSString *)key {
    [self setObject:[NSNumber numberWithDouble:number] forKey:key];
}

- (void)setBool:(BOOL)number forKey:(NSString *)key {
    [self setObject:[NSNumber numberWithInt:number] forKey:key];
}

- (void)removeObjectForKey:(NSString *)key {
    [cacheLock lock];
    [self.globalDict removeObjectForKey:key];
    [cacheLock unlock];
}

- (id)objectForKey:(NSString *)key {
    return [self.globalDict objectForKey:key];
}

- (NSString *)stringForKey:(NSString *)key {
    NSString *string = [self.globalDict stringForKey:key];
    
    return string;
}

- (int)intForKey:(NSString *)key {
    NSString *string = [self stringForKey:key];
    if (!string) {
        return -1;
    }
    return string.intValue;
}

- (uint)uintForKey:(id)key {
    NSString *string = [self stringForKey:key];
    return string.intValue;
}

- (long long)longLongForKey:(NSString *)key {
    NSString *string = [self stringForKey:key];
    return string.longLongValue;
}

- (u_int64_t)ulongLongForKey:(id)key {
    NSString *string = [self stringForKey:key];
    return string.longLongValue;
}

- (float)floatForKey:(NSString *)key {
    NSString *string = [self stringForKey:key];
    return string.floatValue;
}

- (double)doubleForKey:(NSString *)key {
    NSString *string = [self stringForKey:key];
    return string.doubleValue;
}

- (BOOL)boolForKey:(NSString *)key {
    NSString *string = [self stringForKey:key];
    return string.boolValue;
}

- (void)setSecretString:(NSString *)string forKey:(NSString *)key {
    [cacheLock lock];
    [self.secretDict setObject:[string AESEncodeString] forKey:key];
    [cacheLock unlock];
}

- (void)setSecretInt:(int)number forKey:(NSString *)key {
    [self setSecretString:[[NSNumber numberWithInt:number] stringValue] forKey:key];
}

- (void)setSecretFloat:(float)number forKey:(NSString *)key {
    [self setSecretString:[[NSNumber numberWithFloat:number] stringValue] forKey:key];
}

- (void)setSecretDouble:(double)number forKey:(NSString *)key {
    [self setSecretString:[[NSNumber numberWithDouble:number] stringValue] forKey:key];
}

- (void)removeSecretObjectForKey:(NSString *)key {
    [cacheLock lock];
    [self.secretDict removeObjectForKey:key];
    [cacheLock unlock];
}

- (NSString *)secretStringForKey:(NSString *)key {
    NSString *string = [self.secretDict stringForKey:key];
    if (!string) {
        return nil;
    }
    return [string AESDecodeString];
}

- (int)secretIntForKey:(NSString *)key {
    NSString *string = [self.secretDict stringForKey:key];
    if (!string) {
        return -1;
    }
    return [[string AESDecodeString] intValue];
}

- (float)secretFloatForKey:(NSString *)key {
    NSString *string = [self.secretDict stringForKey:key];
    if (!string) {
        return -1.0f;
    }
    return [[string AESDecodeString] floatValue];
}

- (double)secretDoubleForKey:(NSString *)key {
    NSString *string = [self.secretDict stringForKey:key];
    if (!string) {
        return -1.0;
    }
    return [[string AESDecodeString] doubleValue];
}

- (void)synchronize {
    // 0.5秒内只写入一次
    if ([NSThread isMainThread]) {
        [self _synchronize];
    } else {
        [self performSelectorOnMainThread:@selector(_synchronize) withObject:nil waitUntilDone:NO];
    }
    
}

- (void)_synchronize {
    [cacheLock lock];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(synchronizeNow) object:nil];
    [self performSelector:@selector(synchronizeNow) withObject:nil afterDelay:0.5];
    [cacheLock unlock];
}

- (void)synchronizeNow {
    __block __weak typeof(self) weakSelf = self;
    dispatch_async(queue, ^{
        if(!weakSelf.globalDict || !weakSelf.secretDict || !weakSelf.globalPath || !weakSelf.secretPath) {
            NSLog(@"Cache synchronize cancel!");
        } else {
            if ([cacheLock tryLock]) {
                @try {
                    @synchronized (weakSelf.globalDict) {
                        [weakSelf.globalDict writeToFile:weakSelf.globalPath atomically:YES];
                    }
                    @synchronized (weakSelf.secretDict) {
                        [weakSelf.secretDict writeToFile:weakSelf.secretPath atomically:YES];
                    }
                } @catch (NSException *exception) {
                    NSLog(@"%@",exception);
                } @finally {
                    [cacheLock unlock];
                }
            } else {     
                NSLog(@"Lock fail!Cache synchronize cancel!");
            }
        }
    });
}
@end
