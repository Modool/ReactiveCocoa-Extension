//
//  RACSignal+RACReduce.m
//  ReactiveCocoa-Extension
//
//  Created by Jave on 2017/12/16.
//  Copyright © 2017年 markejave. All rights reserved.
//


#import "RACSignal+RACReduce.h"

@implementation RACSignal (RACReduce)

- (instancetype)reduceTake:(NSUInteger)take;{
    NSParameterAssert(take);
    NSUInteger takeIndex = (take - 1);
    return [[self map:^id(RACTuple *tuple) {
        return [tuple objectAtIndex:takeIndex];
    }] setNameWithFormat:@"[%@] -reduceTake:", [self name]];
}

- (instancetype)anyNonullTake;{
    return [[self map:^id(RACTuple *tuple) {
        for (id value in [tuple allObjects]) {
            if (value) return value;
        }
        return nil;
    }] setNameWithFormat:@"[%@] -reduceTake:", [self name]];
}

- (instancetype)anyNullTake;{
    return [[self map:^id(RACTuple *tuple) {
        for (id value in [tuple allObjects]) {
            if (!value) return value;
        }
        return [tuple last];
    }] setNameWithFormat:@"[%@] -reduceTake:", [self name]];
}

@end
