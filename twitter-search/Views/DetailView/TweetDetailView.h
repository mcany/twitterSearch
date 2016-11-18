//
//  TweetDetailView.h
//  twitter-search
//
//  Created by mcan on 17/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetDetailView : UIView

@property (nonatomic, strong) UIImageView *profileImage;
@property (nonatomic, strong) UILabel *profileName;
@property (nonatomic, strong) UIImageView *profileBackgroundImage;

@property (nonatomic, strong) UILabel *tweet;


@end
