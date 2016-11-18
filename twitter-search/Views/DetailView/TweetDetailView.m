//
//  TweetDetailView.m
//  twitter-search
//
//  Created by mcan on 17/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "TweetDetailView.h"

// library
#import "Masonry.h"

@interface TweetDetailView()

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIView *middleView;

@end

@implementation TweetDetailView

- (instancetype)init{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    return self;
}

-(void) layoutSubviews{
    [self updateViewConstraints];
}

- (UIView *)headerView {
    if(!_headerView){
        UIView *headerView = [[UIView alloc]
                              initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 139)];
        [self addSubview:headerView];
        self.headerView = headerView;
    }
    return  _headerView;
}

- (UIImageView *)profileImage {
    if(!_profileImage){
        UIImageView *profileImage = [[UIImageView alloc]
                                     initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 139)];
        [self.headerView addSubview:profileImage];
        self.profileImage = profileImage;
    }
    return  _profileImage;
}

- (UILabel *)profileName {
    if(!_profileName){
        UILabel *profileName = [[UILabel alloc] init];
        [self.headerView addSubview:profileName];
        self.profileName = profileName;
    }
    return  _profileName;
}

- (UIImageView *)profileBackgroundImage {
    if(!_profileBackgroundImage){
        UIImageView *profileBackgroundImage = [[UIImageView alloc]
                                     initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 139)];
        [self.headerView addSubview:profileBackgroundImage];
        self.profileBackgroundImage = profileBackgroundImage;
    }
    return  _profileBackgroundImage;
}

- (UIView *)middleView {
    if(!_middleView){
        UIView *middleView = [[UIView alloc]
                              initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 139)];
        [self addSubview:middleView];
        self.middleView = middleView;
    }
    return  _middleView;
}

- (UILabel *)tweet {
    if(!_tweet){
        UILabel *tweet = [[UILabel alloc] init];
        [tweet setNumberOfLines:0];
        [tweet setLineBreakMode:NSLineBreakByWordWrapping];
        [self.middleView addSubview:tweet];
        self.tweet = tweet;
    }
    return  _tweet;
}

- (void)updateViewConstraints {
    [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
    }];
    [self.profileImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView).offset(16);
        make.left.equalTo(self.headerView);
        make.height.width.equalTo(@50);
    }];
    [self.profileName mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.top.equalTo(self.headerView).offset(16);
    }];
    [self.profileBackgroundImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.profileImage.mas_bottom).offset(16);
        make.left.right.equalTo(self.headerView);
        make.height.equalTo(@250);
    }];
    
    [self.middleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.profileBackgroundImage.mas_bottom);
    }];
    [self.tweet mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView).offset(16);
        make.left.right.equalTo(self.middleView);
    }];
    
}
@end
