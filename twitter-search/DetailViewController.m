//
//  DetailViewController.m
//  twitter-search
//
//  Created by mcan on 15/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "DetailViewController.h"

// library
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "ReactiveCocoa.h"

// class
#import "TweetDetailView.h"
#import "UIColor+HEX.h"

@interface DetailViewController ()

@property (nonatomic, strong) TweetDetailView *tweetDetailView;

@end

@implementation DetailViewController

- (instancetype)init{
    self = [super init];
    
    if (!self) {
        return nil;
    }

    return self;
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem && self.tweetDetailView) {
        self.detailDescriptionLabel.text = [self.detailItem description];
        [self.tweetDetailView.profileName setText:self.detailItem.user.screenName];
        [self.tweetDetailView.tweet setText:self.detailItem.text];
        //[self.view setTextColor:[UIColor colorFromHexString:self.detailItem.user.profileBackgroundColor]];
        [self setImageView:self.tweetDetailView.profileImage ImageURL:self.detailItem.user.profileImageURL];
        [self setImageView:self.tweetDetailView.profileBackgroundImage ImageURL:self.detailItem.user.profileBackgroundImageURL];
        [self.detailDescriptionLabel setHidden:YES];
       // [self.tweetDetailView setBackgroundColor:[UIColor colorFromHexString:self.detailItem.user.profileBackgroundColor]];
    }
}

-(void)setImageView:(UIImageView *)imageView ImageURL:(NSURL *)url{
    if (!imageView) {
        return;
    }
    UIActivityIndicatorView *activityIndicator = [UIActivityIndicatorView new];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    [imageView addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    [activityIndicator mas_updateConstraints: ^(MASConstraintMaker *make) {
        make.center.equalTo(imageView);
    }];
    
    @weakify(activityIndicator);
    [imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(activityIndicator);
        [imageView setImage:image];
        [activityIndicator stopAnimating];
        [activityIndicator removeFromSuperview];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tweetDetailView = [[TweetDetailView alloc] init];
    [self.view addSubview:self.tweetDetailView];
    [self.tweetDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self configureView];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(SearchStatuses *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

@end
