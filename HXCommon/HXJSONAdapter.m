
#import "HXJSONAdapter.h"

@implementation NSString (HXJSONAdapter)
- (id)jsonValue {
    
    if (self.length <= 0) {
        return nil;
    }
    
    NSError *error = nil;
    id jsonValue = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                                   options:NSJSONReadingMutableContainers
                                                     error:&error];
    
    if (error) {
        NSLog(@"json 解析异常,%@",self);
        NSLog(@"%@", [error description]);
        return nil;
    }
    return jsonValue;
    
}


@end

@implementation NSData (HXJSONAdapter)
- (id)jsonValue {
    
    if (self.length <= 0) {
        return nil;
    }

    NSError *error = nil;
    id jsonValue = [NSJSONSerialization JSONObjectWithData:self
                                                   options:NSJSONReadingMutableContainers
                                                     error:&error];
    
    if (error) {
        NSLog(@"json 解析异常,%@",self);
        NSLog(@"%@", [error localizedFailureReason]);
        return nil;
    }
    return jsonValue;

}
@end

@implementation NSDictionary (HXJSONAdapter)

- (NSString *)jsonString {
    
    if (self.allKeys.count <= 0) {
        return nil;
    }
    
    NSError* error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:kNilOptions
                                                         error:&error];
    if (error) {
        NSLog(@"json 解析异常,%@",self);
        NSLog(@"%@", [error localizedFailureReason]);
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
    
}

@end

@implementation NSArray (HXJSONAdapter)

- (NSString *)jsonString {
    
    if (self.count <= 0) {
        return nil;
    }
    
    NSError* error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:kNilOptions
                                                         error:&error];
    if (error) {
        NSLog(@"json 解析异常,%@",self);
        NSLog(@"%@", [error localizedFailureReason]);
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
    
}

@end
