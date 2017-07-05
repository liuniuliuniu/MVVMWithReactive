//
//  LLUser.h
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/4.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLUser : NSObject


- (instancetype)initWithUserId:(NSUInteger)userId;

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *summary;
@property (assign, nonatomic) NSUInteger userId;
@property (assign, nonatomic) NSUInteger blogCount;
@property (assign, nonatomic) NSUInteger friendCount;



@end
