//
//  ASFPSManager.m
//  ASTableView
//
//  Created by AllenQin on 16/6/16.
//  Copyright © 2016年 AllenQin. All rights reserved.
//


#import "ASFPSManager.h"
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kSize CGSizeMake(55, 20)

@implementation ASFPSLabel {
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    UIFont *_font;
    UIFont *_subFont;
    NSTimeInterval _llll;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size = kSize;
    }
    self = [super initWithFrame:frame];
    
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.00];
    
    _font = [UIFont fontWithName:@"Menlo" size:14];
    if (_font) {
        _subFont = [UIFont fontWithName:@"Menlo" size:4];
    } else {
        _font = [UIFont fontWithName:@"Courier" size:14];
        _subFont = [UIFont fontWithName:@"Courier" size:4];
    }
    
    _link = [CADisplayLink displayLinkWithTarget:[YYWeakProxy proxyWithTarget:self] selector:@selector(tick:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    return self;
}

- (void)dealloc {
    [_link invalidate];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return kSize;
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text setColor:color range:NSMakeRange(0, text.length - 3)];
    [text setColor:[UIColor blackColor] range:NSMakeRange(text.length - 3, 3)];
    text.font = _font;
    [text setFont:_subFont range:NSMakeRange(text.length - 4, 1)];
    
    self.attributedText = text;
}

@end

@implementation ASFPSManager{
    ASFPSLabel *_fpsLabel;
}

+ (ASFPSManager *)sharedInstance {
    static ASFPSManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ASFPSManager alloc] init];
    });
    return sharedInstance;
}


- (void)show:(UIView *)superView position:(TYPE)type{
    
    if (!_fpsLabel) {
        _fpsLabel = [[ASFPSLabel alloc]init];
    }
    if (type == RIGHT) {
        
        _fpsLabel.frame = CGRectMake(ScreenWidth -65,superView.size.height-40, 55, 20);
        [superView addSubview:_fpsLabel];
        
    }else if(type == STATUS_BAR){
        
        _fpsLabel.frame = CGRectMake((ScreenWidth-50)/2+70, 0, 50, 20);
        _fpsLabel.backgroundColor = [UIColor clearColor];
        [[((NSObject <UIApplicationDelegate> *)([UIApplication sharedApplication].delegate)) window].rootViewController.view addSubview:_fpsLabel];
   
    }else{
        
        _fpsLabel.frame = CGRectMake(10,superView.size.height-40, 55, 20);
        [superView addSubview:_fpsLabel];
    }
}

- (void)hidden{
    
    [_fpsLabel removeFromSuperview];
    _fpsLabel = nil;
}


@end
