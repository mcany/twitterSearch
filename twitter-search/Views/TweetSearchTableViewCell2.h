//
//  TweetSearchTableViewCell2.h
//  twitter-search
//
//  Created by mcan on 16/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetSearchTableViewCell2 : UITableViewCell

@property (nonatomic, strong) UIImageView *circleView;
@property (nonatomic, strong) UILabel *label;

-(void)setCircleViewImageWithURL:(NSURL *)url;

@end
