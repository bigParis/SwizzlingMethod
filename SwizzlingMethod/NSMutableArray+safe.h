//
//  NSMutableArray+safe.h
//  SwizzlingMethod
//
//  Created by yy on 16/2/16.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (safe)

- (instancetype)safe_objectAtIndex:(NSUInteger)index;
- (void)safe_removeObjectsInRange:(NSRange)range;
@end
