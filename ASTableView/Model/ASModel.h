//
//  ASModel.h
//  tabviewsrcollew
//
//  Created by AllenQin on 16/6/13.
//  Copyright © 2016年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ASModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *content;
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSString *imageName;
@property (nonatomic,assign)       CGFloat  imageWide;
@property (nonatomic,assign)       CGFloat  imageheight;

@end
