//
//  TweetSearchTableViewComponent.h
//  twitter-search
//
//  Created by mcan on 15/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import <UIKit/UIKit.h>

// class
#import "TweetSearch.h"

// protocol
#import "TableCellSelected.h"
#import "PaginationNextResult.h"

@interface TweetSearchTableViewComponent : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) id  <TableCellSelected> cellSelectedDelegate;
@property (nonatomic) id  <PaginationNextResult> nextResultDelegate;

@property (nonatomic, strong) TweetSearch *search;
@property (nonatomic, assign) BOOL isLoading;

@end
