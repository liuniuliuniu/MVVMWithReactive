//
//  PeopleModel.m
//  Reactive Demo
//
//  Created by liushaohua on 2016/10/20.
//  Copyright © 2016年 liushaohua. All rights reserved.
//

#import "PeopleModel.h"

@implementation PeopleModel

+ (instancetype)peopleWithDict:(NSDictionary *)dict{
        
    PeopleModel *model = [PeopleModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
