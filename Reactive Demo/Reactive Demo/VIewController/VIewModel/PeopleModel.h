//
//  PeopleModel.h
//  Reactive Demo
//
//  Created by liushaohua on 2016/10/20.
//  Copyright © 2016年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleModel : NSObject

@property(nonatomic,copy)NSString * name;

@property(nonatomic,copy)NSString * age;


+ (instancetype)peopleWithDict:(NSDictionary *)dict;

@end
