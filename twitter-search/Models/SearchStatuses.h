//
//  SearchStatuses.h
//  twitter-search
//
//  Created by mcan on 16/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import <Foundation/Foundation.h>

// library
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

// class
#import "TweetUser.h"

@interface SearchStatuses : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *id;
@property (nonatomic, copy, readonly) NSString *source;
@property (nonatomic, copy, readonly) NSNumber *favoriteCount;
@property (nonatomic, copy, readonly) NSString *lang;
@property (nonatomic, copy, readonly) NSNumber *retweetCount;
@property (nonatomic, copy, readonly) NSNumber *favorited;
@property (nonatomic, copy, readonly) NSNumber *retweeted;
@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy, readonly) NSDate *createdAt;
@property (nonatomic, strong, readonly) TweetUser *user;

@end
