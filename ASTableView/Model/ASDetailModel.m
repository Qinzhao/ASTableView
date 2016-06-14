//
//  ASDetailModel.m
//  tabviewsrcollew
//
//  Created by AllenQin on 16/6/14.
//  Copyright © 2016年 AllenQin. All rights reserved.
//

#import "ASDetailModel.h"

@implementation ASDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = super.init;
    if (self) {
        _title = dictionary[@"title"];
        _content = dictionary[@"content"];
        _username = dictionary[@"username"];
        _time = dictionary[@"time"];
        _imageName = dictionary[@"imageName"];
        _imageWide = [dictionary[@"wide"] floatValue];
        _imageheight = [dictionary[@"height"] floatValue];
    }
    return self;
}

@end
