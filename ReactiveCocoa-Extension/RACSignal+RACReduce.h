//
//  RACSignal+RACReduce.h
//  ReactiveCocoa-Extension
//
//  Created by Jave on 2017/12/16.
//  Copyright © 2017年 markejave. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>

@interface RACSignal (RACReduce)

- (instancetype)reduceTake:(NSUInteger)take;
- (instancetype)anyNonullTake;
- (instancetype)anyNullTake;

@end
