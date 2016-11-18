//
//  MasterViewViewModel.m
//  twitter-search
//
//  Created by mcan on 17/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "MasterViewViewModel.h"

// manager
#import "APIManager.h"

@implementation MasterViewViewModel

- (RACSignal *)searchTweetsWithKeyword:(NSString *)keyword{
    return [[APIManager search:keyword] map:^id(id value) {
        self.search = [MTLJSONAdapter modelOfClass:[TweetSearch class] fromJSONDictionary:value error:nil];
        return self.search;
    }];
}

- (SearchStatuses *)searchStatusesAtIndex:(NSInteger)index{
    if(self.search && self.search.statuses){
        return [self.search.statuses objectAtIndex:index];
    }
    return nil;
}

- (RACSignal *)nextResults{
    if (!self.search.searchMetadata.nextResults) {
        return [RACSignal error:[[NSError alloc] initWithDomain:@"" code:100 userInfo:nil]];
    }
    return [[APIManager searchNext:self.search.searchMetadata.nextResults] map:^id(id value) {
        self.search = [MTLJSONAdapter modelOfClass:[TweetSearch class] fromJSONDictionary:value error:nil];
        return self.search;
    }];
}

@end
