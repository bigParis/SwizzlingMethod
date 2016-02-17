//
//  NSArray+Safe.h
//  SwizzlingMethod
//
//  Created by yy on 16/2/16.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safe)

- (instancetype)safe_objectAtIndex:(NSUInteger)index;

@end
