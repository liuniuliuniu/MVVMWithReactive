//
//  LLUser.m
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/4.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLUser.h"

@implementation LLUser

- (instancetype)initWithUserId:(NSUInteger)userId {
    
    self.name = [NSString stringWithFormat:@"user%lu",userId];
    self.icon = @"user";
    self.userId = userId;
    self.summary = [NSString stringWithFormat:@"userSummary%ld", userId];
    self.blogCount = userId + 8;
    self.friendCount = userId + 10;
    return self;
}

@end
