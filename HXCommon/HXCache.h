//
//  HTCache.h
//  
//
//  Created by wanghexiang on 16-6-19.
//  Copyright (c) 2016年 uiki. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HXCache : NSObject

+(instancetype)sharedCache;

// 通用配置
- (void)setObject:(id)obj forKey:(NSString *)key;
- (void)setString:(NSString *)string forKey:(NSString *)key;
- (void)setInt:(int)number forKey:(NSString *)key;
- (void)setLong:(long)number forKey:(NSString *)key;
- (void)setFloat:(float)number forKey:(NSString *)key;
- (void)setDouble:(double)number forKey:(NSString *)key;
- (void)setBool:(BOOL)number forKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;

- (id)objectForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (int)intForKey:(NSString *)key;
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

- (void)removeSecretObjectForKey:(NSString *)key;

- (NSString *)secretStringForKey:(NSString *)key;
- (int)secretIntForKey:(NSString *)key;
- (float)secretFloatForKey:(NSString *)key;
- (double)secretDoubleForKey:(NSString *)key;

- (void)synchronize;
@end
