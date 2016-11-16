//
//  TweetSearchTableViewComponent.m
//  twitter-search
//
//  Created by mcan on 15/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "TweetSearchTableViewComponent.h"

// custom class
#import "TweetSearchTableViewCell.h"
#import "TweetSearchTableViewCell2.h"


@interface TweetSearchTableViewComponent()

@property (nonatomic, strong) NSArray *items;

@end

@implementation TweetSearchTableViewComponent

- (instancetype)initWithArray:(NSArray *)items{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.items = items;
    return self;
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier1 = @"TweetsListCell1";
    static NSString *CellIdentifier2 = @"TweetsListCell2";
        
    id cellItem = [self.items objectAtIndex:indexPath.section];
    
    if (indexPath.row % 2 == 1) {
        TweetSearchTableViewCell *cell = (TweetSearchTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier1 forIndexPath:indexPath];
        [cell.label setText:cellItem];
        [cell layoutSubviews];
        return cell;
    }
    
    else {
        TweetSearchTableViewCell2 *cell = (TweetSearchTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
        [cell.label setText:cellItem];
        [cell layoutSubviews];
        return cell;
    }
}

@end
