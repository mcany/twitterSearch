//
//  TweetSearchViewController.m
//  twitter-search
//
//  Created by mcan on 15/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "TweetSearchViewController.h"

// library
#import "Masonry.h"

// custom class
#import "TweetSearchView.h"
#import "TweetSearchTableViewComponent.h"

@interface TweetSearchViewController ()

@property (nonatomic, strong) TweetSearchView *tweetSearchView;
@property (nonatomic, strong) TweetSearchTableViewComponent *tweetSearchTableViewComponent;

@property (nonatomic, strong) NSArray *array;

@end

@implementation TweetSearchViewController
static NSString *cellIdentifier = @"TweetSearchCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tweetSearchView = [[TweetSearchView alloc] initWithReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.tweetSearchView];
    [self.tweetSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.array = @[@"asd", @"asd", @"asd"];
    
    //self.tweetSearchTableViewComponent = [[TweetSearchTableViewComponent alloc] initWithArray:self.array cellIdentifier:cellIdentifier];
    
}

@end
