//
//  NSDictionary+safe.m
//  SwizzlingMethod
//
//  Created by yy on 16/2/16.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "NSDictionary+safe.h"
#import <objc/runtime.h>

@class NSArray<ObjectType>, NSSet<ObjectType>;

@implementation NSDictionary (safe)

+ (void)load {
#ifdef DEBUG
    [super load];
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSPlaceholderDictionary"), @selector(initWithObjects:forKeys:count:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSPlaceholderDictionary"), @selector(safe_initWithObjects:forKeys:count:));
    method_exchangeImplementations(fromMethod, toMethod);
#endif
    
}

//- (instancetype)safe_initWithObjects:(const ObjectType [])objects forKeys:(const KeyType <NSCopying> [])keys count:(NSUInteger)cnt{
//
//}

@end
