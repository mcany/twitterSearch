//
//  DetailViewController.h
//  twitter-search
//
//  Created by mcan on 15/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import <UIKit/UIKit.h>

// class
#import "SearchStatuses.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) SearchStatuses *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

