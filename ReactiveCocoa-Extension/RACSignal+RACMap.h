//
//  RACSignal+RACMap.h
//  ReactiveCocoa-Extension
//
//  Created by Jave on 2017/12/16.
//  Copyright © 2017年 markejave. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>

@interface RACSignal (RACMap)

- (instancetype)mapWithTarget:(id)target performSelector:(SEL)selector;

- (instancetype)mapPerformSelector:(SEL)selector;
- (instancetype)mapPerformSelector:(SEL)selector withObject:(id)object;

- (instancetype)mapSwitch:(NSDictionary *)cases;
- (instancetype)mapSwitch:(NSDictionary *)cases defaultValue:(id)defaultValue;

- (instancetype)mapEqual:(id)value replacement:(id)replacement;
- (instancetype)mapEqual:(id)value replacement:(id)replacement elsewise:(id)elsewise;

- (instancetype)mapSelectTruth:(id)truth;
- (instancetype)mapSelectFallacy:(id)fallacy;
- (instancetype)mapSelectTruth:(id)truth fallacy:(id)fallacy;

- (instancetype)mapNull:(id)null;
- (instancetype)mapNonull:(id)nonull;
- (instancetype)mapNull:(id)null nonull:(id)nonull;

- (instancetype)mapArrayCountGreater:(NSUInteger)count;
- (instancetype)mapArrayCountGreaterZero;

- (instancetype)mapArrayCountLess:(NSUInteger)count;
- (instancetype)mapArrayCountLessZero;

- (instancetype)mapArrayCountEqual:(NSUInteger)count;

- (instancetype)mapIntegerGreater:(NSInteger)integer;
- (instancetype)mapIntegerGreaterZero;

- (instancetype)mapIntegerLess:(NSInteger)integer;
- (instancetype)mapIntegerLessZero;

- (instancetype)mapIntegerEqual:(NSInteger)integer;

- (instancetype)mapStringValue;
- (instancetype)mapBooleanValue;

- (instancetype)mapEqualNil;
- (instancetype)mapNotEqualNil;

- (instancetype)mapStringLengthGreater:(NSInteger)length;
- (instancetype)mapStringLengthGreaterZero;

- (instancetype)mapStringLengthLess:(NSInteger)length;
- (instancetype)mapStringLengthLessZero;

- (instancetype)mapStringLengthEqual:(NSInteger)length;

- (instancetype)mapForKeypath:(NSString *)keypath;
- (instancetype)mapForKey:(NSString *)key;

@end
