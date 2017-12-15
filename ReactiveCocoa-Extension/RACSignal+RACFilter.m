//
//  RACSignal+RACFilter.m
//  ReactiveCocoa-Extension
//
//  Created by Jave on 2017/12/16.
//  Copyright © 2017年 markejave. All rights reserved.
//

#import "RACSignal+RACFilter.h"

@implementation RACSignal (RACFilter)

- (instancetype)equal:(id)value;{
    return [[self map:^id(id innerValue) {
        return @(innerValue == value || [innerValue isEqual:value]);
    }] setNameWithFormat:@"[%@] -equal:", [self name]];
}

- (instancetype)filterTrueTake:(NSUInteger)filter;{
    NSParameterAssert(filter);
    NSUInteger filterIndex = (filter - 1);
    return [[self filter:^BOOL(RACTuple *tuple) {
        return [[tuple objectAtIndex:filterIndex] boolValue];
    }] setNameWithFormat:@"[%@] -filterTake:", [self name]];
}

- (instancetype)filterTrueTake:(NSUInteger)filter reduceTake:(NSUInteger)take;{
    NSParameterAssert(filter && take);
    NSUInteger filterIndex = (filter - 1);
    NSUInteger takeIndex = (take - 1);
    return [[[self filter:^BOOL(RACTuple *tuple) {
        return [[tuple objectAtIndex:filterIndex] boolValue];
    }] map:^id(RACTuple *tuple) {
        return [tuple objectAtIndex:takeIndex];
    }] setNameWithFormat:@"[%@] -filterTrueTake:reduceTake:", [self name]];
}

- (instancetype)filterFalseTake:(NSUInteger)filter;{
    NSParameterAssert(filter);
    NSUInteger filterIndex = (filter - 1);
    return [[self filter:^BOOL(RACTuple *tuple) {
        return ![[tuple objectAtIndex:filterIndex] boolValue];
    }] setNameWithFormat:@"[%@] -filterFalseTake:", [self name]];
}

- (instancetype)filterFalseTake:(NSUInteger)filter reduceTake:(NSUInteger)take;{
    NSParameterAssert(filter && take);
    NSUInteger filterIndex = (filter - 1);
    NSUInteger takeIndex = (take - 1);
    return [[[self filter:^BOOL(RACTuple *tuple) {
        return ![[tuple objectAtIndex:filterIndex] boolValue];
    }] map:^id(RACTuple *tuple) {
        return [tuple objectAtIndex:takeIndex];
    }] setNameWithFormat:@"[%@] -filterFalseTake:reduceTake:", [self name]];
}

+ (instancetype)combineLatest:(id<NSFastEnumeration>)signals filterTrueTake:(NSUInteger)filter;{
    return [[self combineLatest:signals] filterTrueTake:filter];
}

+ (instancetype)combineLatest:(id<NSFastEnumeration>)signals filterTrueTake:(NSUInteger)filter reduceTake:(NSUInteger)take;{
    return [[self combineLatest:signals] filterTrueTake:filter reduceTake:take];
}

+ (instancetype)combineLatest:(id<NSFastEnumeration>)signals filterFalseTake:(NSUInteger)filter;{
    return [[self combineLatest:signals] filterFalseTake:filter];
}

+ (instancetype)combineLatest:(id<NSFastEnumeration>)signals filterFalseTake:(NSUInteger)filter reduceTake:(NSUInteger)take;{
    return [[self combineLatest:signals] filterFalseTake:filter reduceTake:take];
}

- (instancetype)filterWith:(id)value;{
    Class class = [self class];
    
    return [[self flattenMap:^ id (id innerValue) {
        if (innerValue == value || [innerValue isEqual:value]) {
            return [class return:innerValue];
        } else {
            return [class empty];
        }
    }] setNameWithFormat:@"[%@] -filterWith:", [self name]];
}

- (instancetype)filterClass:(Class)filterClass;{
    Class class = [self class];
    
    return [[self flattenMap:^ id (id value) {
        if ([value isKindOfClass:filterClass]) {
            return [class empty];
        } else {
            return [class return:value];
        }
    }] setNameWithFormat:@"[%@] -filterClass:", [self name]];
}

- (instancetype)filterTakeClass:(Class)takeClass;{
    Class class = [self class];
    
    return [[self flattenMap:^ id (id value) {
        if ([value isKindOfClass:takeClass]) {
            return [class return:value];
        } else {
            return [class empty];
        }
    }] setNameWithFormat:@"[%@] -filterClass:", [self name]];
}

- (instancetype)filterRespondsSelector:(SEL)selector;{
    Class class = [self class];
    
    return [[self flattenMap:^ id (id value) {
        if ([value respondsToSelector:selector]) {
            return [class return:value];
        } else {
            return [class empty];
        }
    }] setNameWithFormat:@"[%@] -filterRespondsSelector:", [self name]];
}

- (instancetype)filterPerformSelector:(SEL)selector;{
    Class class = [self class];
    
    return [[self flattenMap:^ id (id value) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if ([value respondsToSelector:selector] && [[value performSelector:selector] boolValue]) {
#pragma clang diagnostic pop
            return [class return:value];
        } else {
            return [class empty];
        }
    }] setNameWithFormat:@"[%@] -filterPerformSelector:", [self name]];
}

- (instancetype)filterWithKeyPath:(NSString *)keypath;{
    Class class = [self class];
    
    return [[self flattenMap:^ id (id value) {
        if ([[value valueForKeyPath:keypath] boolValue]) {
            return [class return:value];
        } else {
            return [class empty];
        }
    }] setNameWithFormat:@"[%@] -filterWithKeyPath:", [self name]];
}

- (instancetype)filterEqualTo:(id)value keyPath:(NSString *)keypath;{
    Class class = [self class];
    
    return [[self flattenMap:^ id (id value) {
        if ([value isEqual:[value valueForKeyPath:keypath]]) {
            return [class return:value];
        } else {
            return [class empty];
        }
    }] setNameWithFormat:@"[%@] -filterEqualTo:keyPath:", [self name]];
}

- (instancetype)filterEqualTo:(id)value selector:(SEL)selector;{
    Class class = [self class];
    
    return [[self flattenMap:^ id (id value) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if ([value isEqual:[value performSelector:selector]]) {
#pragma clang diagnostic pop
            return [class return:value];
        } else {
            return [class empty];
        }
    }] setNameWithFormat:@"[%@] -filterEqualTo:selector:", [self name]];
}

- (instancetype)filterNotEqualTo:(id)value keyPath:(NSString *)keypath;{
    Class class = [self class];
    
    return [[self flattenMap:^ id (id value) {
        if (![value isEqual:[value valueForKeyPath:keypath]]) {
            return [class return:value];
        } else {
            return [class empty];
        }
    }] setNameWithFormat:@"[%@] -filterEqualTo:keyPath:", [self name]];
}

- (instancetype)filterNotEqualTo:(id)value selector:(SEL)selector;{
    Class class = [self class];
    
    return [[self flattenMap:^ id (id value) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if (![value isEqual:[value performSelector:selector]]) {
#pragma clang diagnostic pop
            return [class return:value];
        } else {
            return [class empty];
        }
    }] setNameWithFormat:@"[%@] -filterEqualTo:selector:", [self name]];
}

- (instancetype)filterArrayCountGreater:(NSUInteger)count;{
    return [[self filter:^BOOL(id  _Nullable value) {
        NSParameterAssert([value performSelector:@selector(count)]);
        return [value count] > count;
    }] setNameWithFormat:@"[%@] -filterArrayCountGreater:", [self name]];
}

- (instancetype)filterArrayCountGreaterZero;{
    return [[self filterArrayCountGreater:0] setNameWithFormat:@"[%@] -filterArrayCountGreaterZero", [self name]];
}

- (instancetype)filterArrayCountLess:(NSUInteger)count;{
    return [[self filter:^BOOL(id  _Nullable value) {
        NSParameterAssert([value performSelector:@selector(count)]);
        return [value count] < count;
    }] setNameWithFormat:@"[%@] -filterArrayCountLess:", [self name]];
}
- (instancetype)filterArrayCountLessZero;{
    return [[self filterArrayCountLess:0] setNameWithFormat:@"[%@] -filterArrayCountLessZero", [self name]];
}

- (instancetype)filterArrayCountEqual:(NSUInteger)count;{
    return [[self filter:^BOOL(id  _Nullable value) {
        NSParameterAssert([value performSelector:@selector(count)]);
        return [value count] == count;
    }] setNameWithFormat:@"[%@] -filterArrayCountEqual:", [self name]];
}

- (instancetype)filterEqualNil;{
    return [[self ignore:nil] setNameWithFormat:@"[%@] -filterEqualNil", [self name]];
}
    
- (instancetype)filterNotEqualNil;{
    return [[self filter:^BOOL(id  _Nullable value) {
        return value != nil;
    }] setNameWithFormat:@"[%@] -filterNotEqualNil", [self name]];
}

- (instancetype)filterBooleanPositive;{
    return [[self filter:^BOOL(id  _Nullable value) {
        NSParameterAssert([value performSelector:@selector(boolValue)]);
        return [value boolValue];
    }] setNameWithFormat:@"[%@] -filterBooleanPositive", [self name]];
}

- (instancetype)filterBooleanNegation;{
    return [[self filter:^BOOL(id  _Nullable value) {
        NSParameterAssert([value performSelector:@selector(boolValue)]);
        return ![value boolValue];
    }] setNameWithFormat:@"[%@] -filterBooleanNegation", [self name]];
}

@end
