//
//  ASDetailTableViewCell.m
//  tabviewsrcollew
//
//  Created by AllenQin on 16/6/14.
//  Copyright © 2016年 AllenQin. All rights reserved.
//

#import "ASDetailTableViewCell.h"
@interface ASDetailTableViewCell ()

@property (nonatomic, strong) YYLabel *titleLabel;
@property (nonatomic, strong) YYLabel *contentLabel;
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) YYLabel *usernameLabel;
@property (nonatomic, strong) YYLabel *timeLabel;

@end


@implementation ASDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _titleLabel = [YYLabel new];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor blueColor];
    _titleLabel.displaysAsynchronously = YES;
    [self.contentView addSubview:_titleLabel];
    _contentLabel = [YYLabel new];
    _contentLabel.textColor = [UIColor darkGrayColor];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.displaysAsynchronously = YES;
    _contentLabel.numberOfLines = 0;
    //加上否则不好使。。
    _contentLabel.preferredMaxLayoutWidth = ScreenWidth - 60;
    [self.contentView addSubview:_contentLabel];
    _usernameLabel = [YYLabel new];
    _usernameLabel.font = [UIFont systemFontOfSize:13];
    _usernameLabel.textColor = [UIColor lightGrayColor];
    _usernameLabel.displaysAsynchronously = YES;
    [self.contentView addSubview:_usernameLabel];
    _timeLabel = [YYLabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor blueColor];
    [_timeLabel sizeToFit];
    _timeLabel.displaysAsynchronously = YES;
    [self.contentView addSubview:_timeLabel];
    _contentImageView = [UIImageView new];
    [self.contentView addSubview:_contentImageView];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.top.equalTo(self.contentView.mas_top).with.offset(13);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(8);
        make.width.mas_equalTo(ScreenWidth - 60);
        make.bottom.equalTo(_contentImageView.mas_top).with.offset(-8);
    }];
    
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(0);
        make.bottom.equalTo(_usernameLabel.mas_top).with.offset(-8);
        
    }];
    
    [_usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-4);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(280);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-4);
    }];
    
    return self;
    
}



- (void)setModel:(ASDetailModel *)model{
    
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    self.usernameLabel.text = model.username;
    self.timeLabel.text = model.time;
    if (model.title.length == 0) {
        [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).with.offset(0);
        }];
    }else{
        [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).with.offset(8);
        }];
    }
    if (model.imageName.length > 0) {
        if (model.imageWide>0 && model.imageheight>0) {
            
            CGFloat scale = model.imageWide/model.imageheight;
            if (model.imageWide >model.imageheight) {
                
                [self.contentImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(250);
                    make.height.mas_equalTo(250/scale);
                }];
                
            }else{
                [self.contentImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(250*scale);
                    make.height.mas_equalTo(250);
                }];
            }
            
            [self.contentImageView setImageWithURL:[NSURL URLWithString:model.imageName] placeholder:[UIImage imageNamed:@"defult"] options:YYWebImageOptionShowNetworkActivity completion:nil];
        }else{
            
            self.contentImageView.image  =  nil;
            [self.contentImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
                make.width.mas_equalTo(0);
            }];
            
        }
        
        
    }else{
        
        self.contentImageView.image  =  nil;
        [self.contentImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
            make.width.mas_equalTo(0);
        }];
        
    }
}
@end
