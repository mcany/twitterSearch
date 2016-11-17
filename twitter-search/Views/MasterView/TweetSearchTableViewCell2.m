//
//  TweetSearchTableViewCell2.m
//  twitter-search
//
//  Created by mcan on 16/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "TweetSearchTableViewCell2.h"

// library
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "ReactiveCocoa.h"

@implementation TweetSearchTableViewCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES; // just to make sure we're calculating the height correctly
        [self.layer setMasksToBounds:YES];
        
        UIImageView *circleView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,20,20)];
        circleView.layer.cornerRadius = 10;
        self.circleView = circleView;
        [self.contentView addSubview:self.circleView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:self.textLabel.frame];
        [label setNumberOfLines:0];
        [label setLineBreakMode:NSLineBreakByWordWrapping];
        [label setTextColor:[UIColor redColor]];
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
        make.right.equalTo(self.contentView).offset(-16);
    }];
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.circleView.mas_left).offset(-16);
        make.left.bottom.top.equalTo(self.contentView);
    }];
}

-(void)setCircleViewImageWithURL:(NSURL *)url{
    
    UIActivityIndicatorView *activityIndicator = [UIActivityIndicatorView new];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    [self.circleView addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    [activityIndicator mas_updateConstraints: ^(MASConstraintMaker *make) {
        make.center.equalTo(self.circleView);
    }];
    
    @weakify(activityIndicator);
    [self.circleView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(activityIndicator);
        [self.circleView setImage:image];
        [activityIndicator stopAnimating];
        [activityIndicator removeFromSuperview];
    }];
}

@end
