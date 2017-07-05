//
//  LLUserInfoViewModel.h
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/4.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LLUser;
@interface LLUserInfoViewModel : NSObject

+ (instancetype)viewModelWithUserID:(NSUInteger)userID;

- (RACCommand *)fetchUserInfoCommand;

@property (strong, nonatomic) LLUser *user;
@property (strong, nonatomic) UIImage *icon;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *summary;
@property (copy, nonatomic) NSString *blogCount;
@property (copy, nonatomic) NSString *friendCount;



@end
