//
//  ASFPSManager.h
//  ASTableView
//
//  Created by AllenQin on 16/6/16.
//  Copyright © 2016年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    LEFT,
    RIGHT,
    STATUS_BAR
} TYPE;


@interface ASFPSLabel : UILabel

@end

@interface ASFPSManager : NSObject

+ (ASFPSManager *)sharedInstance;

- (void)show:(UIView *)superView position:(TYPE)type;

- (void)hidden;

@end



