//
//  ASModel.m
//  tabviewsrcollew
//
//  Created by AllenQin on 16/6/13.
//  Copyright © 2016年 AllenQin. All rights reserved.
//

#import "ASModel.h"

@implementation ASModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = super.init;
    if (self) {
        _title = dictionary[@"title"];
        _content = dictionary[@"content"];
        _username = dictionary[@"username"];
        _time = dictionary[@"time"];
        _imageName = dictionary[@"imageName"];
    }
    return self;
}


@end
