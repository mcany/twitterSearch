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
#import "SearchStatuses.h"

@interface TweetSearchTableViewComponent()

@end

@implementation TweetSearchTableViewComponent

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.search ? [self.search count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier1 = @"TweetsListCell1";
    static NSString *CellIdentifier2 = @"TweetsListCell2";
        
    SearchStatuses *cellItem = [self.search.statuses objectAtIndex:indexPath.row];
    
    if (indexPath.row % 2 == 1) {
        TweetSearchTableViewCell *cell = (TweetSearchTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier1 forIndexPath:indexPath];
        
        [cell setCircleViewImageWithURL:cellItem.user.profileImageURL];
        [cell.label setText:cellItem.text];
        [cell layoutSubviews];
        return cell;
    }
    
    else {
        TweetSearchTableViewCell2 *cell = (TweetSearchTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
        [cell setCircleViewImageWithURL:cellItem.user.profileImageURL];
        [cell.label setText:cellItem.text];
        [cell layoutSubviews];
        return cell;
    }
}

@end
