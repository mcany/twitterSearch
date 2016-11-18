//
//  TweetSearchView.m
//  twitter-search
//
//  Created by mcan on 15/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "TweetSearchView.h"

// library
#import "Masonry.h"

// custom class
#import "TweetSearchTableViewCell.h"
#import "TweetSearchTableViewCell2.h"

@interface TweetSearchView()

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIView *middleView;

@end

@implementation TweetSearchView

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
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 139)];
        [self addSubview:headerView];
        self.headerView = headerView;
    }
    return  _headerView;
}

- (UITextField *)searchTextField {
    if(!_searchTextField){
        UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.headerView.frame), CGRectGetHeight(self.headerView.frame))];
        [searchTextField setText:@"test"];
        [searchTextField setTextAlignment:NSTextAlignmentCenter];
        [searchTextField setBorderStyle:UITextBorderStyleLine];
        [self.headerView addSubview:searchTextField];
        self.searchTextField = searchTextField;
    }
    return  _searchTextField;
}

- (UIView *)middleView {
    if(!_middleView){
        UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 139)];
        [middleView setBackgroundColor:[UIColor blackColor]];
        [self addSubview:middleView];
        self.middleView = middleView;
    }
    return  _middleView;
}

- (UITableView *)tweetsTableView {
    if (!_tweetsTableView) {
        UITableView *tweetsTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0,CGRectGetWidth(self.middleView.frame), 70)];
        tweetsTableView.rowHeight = UITableViewAutomaticDimension;
        tweetsTableView.estimatedRowHeight = 44;
        
        NSString *CellIdentifier1 = @"TweetsListCell1";
        NSString *CellIdentifier2 = @"TweetsListCell2";
        
        [tweetsTableView registerClass:[TweetSearchTableViewCell class] forCellReuseIdentifier:CellIdentifier1];
        [tweetsTableView registerClass:[TweetSearchTableViewCell2 class] forCellReuseIdentifier:CellIdentifier2];
        
        [self.middleView addSubview:tweetsTableView];
        self.tweetsTableView = tweetsTableView;
    }
    return _tweetsTableView;
}

- (void)updateViewConstraints {
    [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@50);
    }];
    [self.searchTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headerView);
    }];
    
    [self.middleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headerView);
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(self);
    }];
    [self.tweetsTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.middleView);
    }];
}

@end
