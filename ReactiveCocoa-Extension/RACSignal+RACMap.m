//
//  RACSignal+RACMap.m
//  ReactiveCocoa-Extension
//
//  Created by Jave on 2017/12/16.
//  Copyright © 2017年 markejave. All rights reserved.
//

#import "RACSignal+RACMap.h"

@implementation RACSignal (RACMap)


- (instancetype)mapWithTarget:(id)target performSelector:(SEL)selector;{
    @weakify(target);
    return [[self map:^id(id value) {
        @strongify(target);
        NSParameterAssert([target respondsToSelector:selector]);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:selector withObject:value];
#pragma clang diagnostic pop
    }] setNameWithFormat:@"[%@] -mapWithTarget:performSelector:", [self name]];
}

- (instancetype)mapPerformSelector:(SEL)selector;{
    return [[self mapPerformSelector:selector withObject:nil] setNameWithFormat:@"[%@] -mapPerformSelector:", [self name]];
}

- (instancetype)mapPerformSelector:(SEL)selector withObject:(id)object;{
    return [[self map:^id(id value) {
        NSParameterAssert([value respondsToSelector:selector]);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [value performSelector:selector withObject:object];
#pragma clang diagnostic pop
    }] setNameWithFormat:@"[%@] -mapPerformSelector:withObject:", [self name]];
}

- (instancetype)mapSwitch:(NSDictionary *)cases;{
    return [[self mapSwitch:cases defaultValue:nil] setNameWithFormat:@"[%@] -mapSwitch:", [self name]];
}

- (instancetype)mapSwitch:(NSDictionary *)cases defaultValue:(id)defaultValue;{
    return [[self map:^id(id innerValue) {
        if (!innerValue) return nil;
        
        id value = cases[innerValue];
        if (value) return value;
        
        return defaultValue;
    }] setNameWithFormat:@"[%@] -mapSwitch:defaultValue:", [self name]];
}

- (instancetype)mapEqual:(id)value replacement:(id)replacement{
    return [[self mapEqual:value replacement:replacement elsewise:nil] setNameWithFormat:@"[%@] -mapEqual:replacement:", [self name]];
}

- (instancetype)mapEqual:(id)value replacement:(id)replacement elsewise:(id)elsewise;{
    return [[self map:^id(id innerValue) {
        return (innerValue == value || [innerValue isEqual:value]) ? replacement : elsewise;
    }] setNameWithFormat:@"[%@] -mapEqual:replacement:elsewise:", [self name]];
}

- (instancetype)mapSelectTruth:(id)truth;{
    return [[self mapSelectTruth:truth fallacy:nil] setNameWithFormat:@"[%@] -mapSelectTruth:", [self name]];
}

- (instancetype)mapSelectFallacy:(id)fallacy;{
    return [[self mapSelectTruth:nil fallacy:fallacy] setNameWithFormat:@"[%@] -mapSelectFallacy:", [self name]];
}

- (instancetype)mapSelectTruth:(id)truth fallacy:(id)fallacy;{
    return [[self map:^id(id value) {
        if (!value) return nil;
        if (![value isKindOfClass:[NSNumber class]]) return nil;
        
        return [value boolValue] ? truth : fallacy;
    }] setNameWithFormat:@"[%@] -mapSelectTruth:fallacy:", [self name]];
}

- (instancetype)mapNull:(id)null;{
    return [[self mapNull:null nonull:nil] setNameWithFormat:@"[%@] -mapNull:", [self name]];
}

- (instancetype)mapNonull:(id)nonull;{
    return [[self mapNull:nil nonull:nonull] setNameWithFormat:@"[%@] -mapNonull:", [self name]];
}

- (instancetype)mapNull:(id)null nonull:(id)nonull;{
    return [[self map:^id(id value) {
        return value ? nonull : null;
    }] setNameWithFormat:@"[%@] -mapNull:nonull:", [self name]];
}

- (instancetype)mapArrayCountGreater:(NSUInteger)count;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        NSParameterAssert(!value || [value isKindOfClass:[NSArray class]]);
        return @([value ?: @[] count] > count);
    }] setNameWithFormat:@"[%@] -mapArrayCountGreater:", [self name]];
}

- (instancetype)mapArrayCountGreaterZero;{
    return [[self mapArrayCountGreater:0] setNameWithFormat:@"[%@] -mapArrayCountGreaterZero", [self name]];
}

- (instancetype)mapArrayCountLess:(NSUInteger)count;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        NSParameterAssert(!value || [value isKindOfClass:[NSArray class]]);
        return @([value ?: @[] count] < count);
    }] setNameWithFormat:@"[%@] -mapArrayCountLess:", [self name]];
}

- (instancetype)mapArrayCountLessZero;{
    return [[self mapArrayCountLess:0] setNameWithFormat:@"[%@] -mapArrayCountLessZero", [self name]];
}

- (instancetype)mapArrayCountEqual:(NSUInteger)count;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        NSParameterAssert(!value || [value isKindOfClass:[NSArray class]]);
        return @([value ?: @[] count] == count);
    }] setNameWithFormat:@"[%@] -mapArrayCountEqual:", [self name]];
}

- (instancetype)mapIntegerGreater:(NSInteger)integer;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        NSParameterAssert(!value || [value respondsToSelector:@selector(integerValue)]);
        return @([value integerValue] > integer);
    }] setNameWithFormat:@"[%@] -mapIntegerGreater:", [self name]];
}

- (instancetype)mapIntegerGreaterZero;{
    return [[self mapIntegerGreater:0] setNameWithFormat:@"[%@] -mapIntegerGreaterZero", [self name]];
}

- (instancetype)mapIntegerLess:(NSInteger)integer;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        NSParameterAssert(!value || [value respondsToSelector:@selector(integerValue)]);
        return @([value integerValue] < integer);
    }] setNameWithFormat:@"[%@] -mapIntegerLess:", [self name]];
}

- (instancetype)mapIntegerLessZero;{
    return [[self mapIntegerLess:0] setNameWithFormat:@"[%@] -mapIntegerLessZero", [self name]];
}

- (instancetype)mapIntegerEqual:(NSInteger)integer;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        NSParameterAssert(!value || [value respondsToSelector:@selector(integerValue)]);
        return @([value integerValue] == integer);
    }] setNameWithFormat:@"[%@] -mapIntegerLess:", [self name]];
}

- (instancetype)mapStringValue;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        return [value description];
    }] setNameWithFormat:@"[%@] -mapStringValue", [self name]];
}

- (instancetype)mapBooleanValue;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        NSParameterAssert(!value || [value respondsToSelector:@selector(boolValue)]);
        
        return @([value boolValue]);
    }] setNameWithFormat:@"[%@] -mapBooleanValue", [self name]];
}

- (instancetype)mapEqualNil;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        return @(value == nil);
    }] setNameWithFormat:@"[%@] -mapEqualNil", [self name]];
}

- (instancetype)mapNotEqualNil;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        return @(value != nil);
    }] setNameWithFormat:@"[%@] -mapNotEqualNil", [self name]];
}

- (instancetype)mapStringLengthGreater:(NSInteger)length;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        NSParameterAssert(!value || [value isKindOfClass:[NSString class]]);
        return @([value length] > length);
    }] setNameWithFormat:@"[%@] -mapStringLengthGreater:", [self name]];
}

- (instancetype)mapStringLengthGreaterZero;{
    return [[self mapStringLengthGreater:0] setNameWithFormat:@"[%@] -mapStringLengthGreaterZero", [self name]];
}

- (instancetype)mapStringLengthLess:(NSInteger)length;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        NSParameterAssert(!value || [value isKindOfClass:[NSString class]]);
        return @([value length] < length);
    }] setNameWithFormat:@"[%@] -mapStringLengthLess:", [self name]];
}

- (instancetype)mapStringLengthLessZero;{
    return [[self mapStringLengthLess:0] setNameWithFormat:@"[%@] -mapStringLengthLessZero", [self name]];
}

- (instancetype)mapStringLengthEqual:(NSInteger)length;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        NSParameterAssert(!value || [value isKindOfClass:[NSString class]]);
        return @([value length] == length);
    }] setNameWithFormat:@"[%@] -mapStringLengthEqual:", [self name]];
}

- (instancetype)mapForKeypath:(NSString *)keypath;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        return [value valueForKeyPath:keypath];
    }] setNameWithFormat:@"[%@] -mapForKeypath:", [self name]];
}

- (instancetype)mapForKey:(NSString *)key;{
    return [[self map:^id _Nullable(id  _Nullable value) {
        return [value valueForKey:key];
    }] setNameWithFormat:@"[%@] -mapForKey:", [self name]];
}

@end
