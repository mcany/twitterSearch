//
//  MasterViewViewModel.h
//  twitter-search
//
//  Created by mcan on 17/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import <Foundation/Foundation.h>

// Library
#import "ReactiveCocoa.h"

// class
#import "TweetSearch.h"
#import "SearchStatuses.h"

@interface MasterViewViewModel : NSObject

@property (nonatomic, strong) TweetSearch *search;

- (RACSignal *)searchTweetsWithKeyword:(NSString *)keyword;
- (SearchStatuses *)searchStatusesAtIndex:(NSInteger)index;
- (RACSignal *)nextResults;

@end
