//
//  NSArray+Safe.m
//  SwizzlingMethod
//
//  Created by yy on 16/2/16.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "NSArray+Safe.h"
#import <objc/runtime.h>

@implementation NSArray (Safe)

+ (void)load {
#ifndef DEBUG
    [super load];
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(safe_objectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);
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

@end
