//
//  MasterViewController.h
//  twitter-search
//
//  Created by mcan on 15/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import <UIKit/UIKit.h>

// protocol
#import "TableCellSelected.h"
#import "PaginationNextResult.h"

@class DetailViewController;

@interface MasterViewController : UIViewController <TableCellSelected, PaginationNextResult>

@property (strong, nonatomic) DetailViewController *detailViewController;

@end

