//
//  MasterViewViewModel.m
//  twitter-search
//
//  Created by mcan on 17/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "MasterViewViewModel.h"

// class
#import "APIManager.h"

@implementation MasterViewViewModel

- (RACSignal *)searchTweetsWithKeyword:(NSString *)keyword{
    return [[APIManager search:keyword] map:^id(id value) {
        self.search = [MTLJSONAdapter modelOfClass:[TweetSearch class] fromJSONDictionary:value error:nil];
        return self.search;
    }];
}

@end
