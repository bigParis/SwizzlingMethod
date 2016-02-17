//
//  NSMutableArray+safe.m
//  SwizzlingMethod
//
//  Created by yy on 16/2/16.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "NSMutableArray+safe.h"
#import <objc/runtime.h>

@implementation NSMutableArray (safe)

+ (void)load {
#ifdef DEBUG
    [super load];
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(safe_objectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);

    Method removeObjectsInRangeFromMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(removeObjectsInRange:));
    Method removeObjectsInRangeToMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(safe_removeObjectsInRange:));
    
    method_exchangeImplementations(removeObjectsInRangeFromMethod, removeObjectsInRangeToMethod);
#endif
}

- (instancetype)safe_objectAtIndex:(NSUInteger)index {
    if (self.count - 1 < index) {
        @try {
            return [self safe_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {
        }
    } else {
        return [self safe_objectAtIndex:index];
    }
    
}

- (void)safe_removeObjectsInRange:(NSRange)range {
    NSUInteger end = range.location + range.length - 1;
    if (end > self.count - 1) {
        @try {
            [self safe_removeObjectsInRange:range];
        }
        @catch (NSException *exception) {
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
        }
        @finally {
        
        }
    } else {
        [self safe_removeObjectsInRange:range];
    }
}
@end
