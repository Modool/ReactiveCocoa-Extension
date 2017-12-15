//
//  RACSignal+RACFilter.h
//  ReactiveCocoa-Extension
//
//  Created by Jave on 2017/12/16.
//  Copyright © 2017年 markejave. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>

@interface RACSignal (RACFilter)

- (instancetype)equal:(id)value;

- (instancetype)filterTrueTake:(NSUInteger)filter;
- (instancetype)filterTrueTake:(NSUInteger)filter reduceTake:(NSUInteger)take;

- (instancetype)filterFalseTake:(NSUInteger)filter;
- (instancetype)filterFalseTake:(NSUInteger)filter reduceTake:(NSUInteger)take;

+ (instancetype)combineLatest:(id<NSFastEnumeration>)signals filterTrueTake:(NSUInteger)filter;
+ (instancetype)combineLatest:(id<NSFastEnumeration>)signals filterTrueTake:(NSUInteger)filter reduceTake:(NSUInteger)take;

+ (instancetype)combineLatest:(id<NSFastEnumeration>)signals filterFalseTake:(NSUInteger)filter;
+ (instancetype)combineLatest:(id<NSFastEnumeration>)signals filterFalseTake:(NSUInteger)filter reduceTake:(NSUInteger)take;

- (instancetype)filterWith:(id)value;
- (instancetype)filterClass:(Class)class;
- (instancetype)filterTakeClass:(Class)class;

- (instancetype)filterRespondsSelector:(SEL)selector;
- (instancetype)filterPerformSelector:(SEL)selector;

- (instancetype)filterWithKeyPath:(NSString *)keypath;

- (instancetype)filterEqualTo:(id)value keyPath:(NSString *)keypath;
- (instancetype)filterEqualTo:(id)value selector:(SEL)selector;

- (instancetype)filterNotEqualTo:(id)value keyPath:(NSString *)keypath;
- (instancetype)filterNotEqualTo:(id)value selector:(SEL)selector;

- (instancetype)filterArrayCountGreater:(NSUInteger)count;
- (instancetype)filterArrayCountGreaterZero;

- (instancetype)filterArrayCountLess:(NSUInteger)count;
- (instancetype)filterArrayCountLessZero;

- (instancetype)filterArrayCountEqual:(NSUInteger)count;

- (instancetype)filterEqualNil;
- (instancetype)filterNotEqualNil;

- (instancetype)filterBooleanPositive;
- (instancetype)filterBooleanNegation;

@end
