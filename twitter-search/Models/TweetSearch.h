//
//  TweetSearch.h
//  twitter-search
//
//  Created by mcan on 16/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import <Foundation/Foundation.h>

// Library
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

// class
#import "SearchMetadata.h"

@interface TweetSearch : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong, readonly) SearchMetadata *searchMetadata;
@property (nonatomic, copy, readonly) NSArray *statuses;

- (NSInteger)count;

@end
