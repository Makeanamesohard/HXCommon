
//
//  HTUserCache.m
//  
//
//  Created by zhuzhi on 13-7-22.
//  Copyright (c) 2013年 HT. All rights reserved.
//

#import "HXUserCache.h"


@interface HXUserCache () {
    NSRecursiveLock *cacheLock;
    dispatch_queue_t queue;
}

@property (nonatomic,copy) NSString *userId;

@property (nonatomic,copy) NSString *userPath;
@property (nonatomic,copy) NSString *secretPath;

@property (atomic,strong) NSMutableDictionary *userDict;
@property (atomic,strong) NSMutableDictionary *secretDict;

@end

@implementation HXUserCache

+ (HXUserCache *)shareCache
{
    static HXUserCache *userCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userCache = [[self alloc]init];
    });
    
    return userCache;
}


- (id)init {
    self = [super init];
    if (self) {
        cacheLock = [[NSRecursiveLock alloc] init];
        queue = dispatch_queue_create("UserCache", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)setUser:(NSString *)userId {
    NSString *docs = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:userId];
    BOOL createDirectory = [[NSFileManager defaultManager] createDirectoryAtPath:docs withIntermediateDirectories:YES attributes:nil error:nil];
    if(!createDirectory)
    {
        NSLog(@"UserCache  不能创建用户目录");
        return;
    }
    
    if (userId.length == 0) {
        return;
    }
    
    if (![self.userId isEqualToString:userId]) {
        self.userId = userId;
        if (self.userDict.count > 0) {
            [cacheLock lock];
            
            @try {
                [self.userDict writeToFile:self.userPath atomically:YES];
                [self.secretDict writeToFile:self.secretPath atomically:YES];
            } @catch (NSException *exception) {
                NSLog(@"%@",exception);
            } @finally {
                [cacheLock unlock];
            }
        }
        [self initCache];
    }
    
}

- (void)initCache {
    
    [cacheLock lock];
    
    NSString *userPath = [[HXPath userPathWithUserId:self.userId] stringByAppendingPathComponent:@"user.plist"];
    self.userPath = userPath;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:userPath]) {
        self.userDict = [NSMutableDictionary dictionaryWithContentsOfFile:userPath];
    } else {
        self.userDict = [NSMutableDictionary dictionary];
       
    }
    
    [self setString:self.userId forKey:UID];
    
    NSString *secretPath = [[HXPath userPathWithUserId:self.userId] stringByAppendingPathComponent:@"secret.plist"];
    self.secretPath = secretPath;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:secretPath]) {
        self.secretDict = [NSMutableDictionary dictionaryWithContentsOfFile:secretPath];
    } else {
        self.secretDict = [NSMutableDictionary dictionary];
    }
    
    [cacheLock unlock];
    
}

- (void)setObject:(id)object forKey:(id)key {
    [cacheLock lock];
    [self.userDict setObject:object forKey:key];
    [cacheLock unlock];
}

- (void)setString:(NSString *)string forKey:(NSString *)key {
    if ([key isEqualToString:UID]) {
        [[NSUserDefaults standardUserDefaults] setObject:string forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [self setObject:string forKey:key];
}

- (void)setInt:(int)number forKey:(NSString *)key {
    [self setObject:[NSNumber numberWithInt:number] forKey:key];
}

- (void)setLongLong:(long long)number forKey:(NSString *)key {
    [self setObject:[NSNumber numberWithLongLong:number] forKey:key];
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

- (id)objectForKey:(id)key {
    [cacheLock lock];
    id obj = [self.userDict objectForKey:key];
    [cacheLock unlock];
    return obj;
}

- (NSString *)stringForKey:(NSString *)key {
    if ([key isEqualToString:UID]) {
        return self.userId;
    }
    [cacheLock lock];
    NSString *string = [self.userDict stringForKey:key];
    [cacheLock unlock];
    return string;
}

- (NSMutableDictionary *)mutableDictionaryForKey:(NSString *)key {
    NSDictionary *dict = [self objectForKey:key];
    if (dict) {
        return [dict mutableCopy];
    }
    return nil;
}

- (int)intForKey:(NSString *)key {
    NSString *string = [self stringForKey:key];
    
    if (string==nil || string.length<1) {
        return -1;
    }
    
    return string.intValue;
}

- (NSInteger)integerForKey:(NSString *)key {
    NSString *string = [self stringForKey:key];
    
    if (!string) {
        return -1;
    }
    
    return string.integerValue;
}

- (uint)uintForKey:(id)key {
    NSString *string = [self stringForKey:key];
    return string.intValue;
}

- (long long)longLongForKey:(NSString *)key {
    NSString *string = [self stringForKey:key];
    
    if (!string) {
        return -1;
    }
    
    return string.longLongValue;
}

- (u_int64_t)ulongLongForKey:(id)key {
    NSString *string = [self stringForKey:key];
    return string.longLongValue;
}

- (float)floatForKey:(NSString *)key {
    NSString *string = [self stringForKey:key];
    if (!string) {
        return -1;
    }
    return string.floatValue;
}

- (double)doubleForKey:(NSString *)key {
    NSString *string = [self stringForKey:key];
    if (!string) {
        return -1;
    }
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
        [self performSelectorOnMainThread:@selector(_synchronize) withObject:nil waitUntilDone:YES];
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
        if(!weakSelf.userId || !weakSelf.userDict || !weakSelf.secretDict || !weakSelf.userPath || !weakSelf.secretPath) {
            NSLog(@"UserCache synchronize cancel!");
        } else {
            
            if ([cacheLock tryLock]) {
                @try {
                    @synchronized (weakSelf.userDict) {
                        [weakSelf.userDict writeToFile:weakSelf.userPath atomically:YES];
                    }
                    @synchronized (weakSelf.secretDict) {
                        [weakSelf.secretDict writeToFile:weakSelf.secretPath atomically:YES];
                    }
                } @catch (NSException *exception) {
                    
                } @finally {
                    [cacheLock unlock];
                }
                NSLog(@"UserCache synchronize!");
            } else {
                NSLog(@"Lock fail!UserCache synchronize cancel!");
            }
            
        }

    });
}




@end
