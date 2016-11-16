//
//  TweetSearchTableViewCell.m
//  twitter-search
//
//  Created by mcan on 15/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "TweetSearchTableViewCell.h"

// library
#import "Masonry.h"

@implementation TweetSearchTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES; // just to make sure we're calculating the height correctly
        [self.layer setMasksToBounds:YES];
        
        UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,20,20)];
        circleView.layer.cornerRadius = 10;
        self.circleView = circleView;
        [self.contentView addSubview:self.circleView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:self.textLabel.frame];
        [label setNumberOfLines:0];
        [label setLineBreakMode:NSLineBreakByWordWrapping];
        self.label = label;
        [self.contentView addSubview:self.label];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self updateViewConstraints];
}

- (void)updateViewConstraints {
    [self.circleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
        make.left.equalTo(self.contentView).offset(16);
    }];
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        //make.left.equalTo(self.circleView.mas_right).offset(16);
        //make.right.bottom.top.equalTo(self.contentView);
        make.center.equalTo(self.contentView);
    }];
}

@end
