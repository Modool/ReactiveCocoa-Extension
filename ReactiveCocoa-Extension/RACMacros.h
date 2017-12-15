//
//  RACMacros.h
//  ReactiveCocoa-Extension
//
//  Created by Jave on 2017/12/16.
//  Copyright © 2017年 markejave. All rights reserved.
//

#ifdef __OBJC__

#import <UIKit/UIKit.h>

#define RACMapArrayCountCondition(condition, input)   ^(id value){ NSParameterAssert(!value || [value isKindOfClass:[NSArray class]]); return @([value ?: @[] count] condition (input)); }

#define RACFilterArrayCountCondition(condition, input)   ^BOOL(id value){ NSParameterAssert(!value || [value isKindOfClass:[NSArray class]]); return ([value ?: @[] count] condition (input)); }

#define RACMapStringLengthCondition(condition, input)  ^(id value){ NSParameterAssert(!value || [value isKindOfClass:[NSString class]]); return @([value length] condition (input)); }

#endif /* RACMacros_h */
