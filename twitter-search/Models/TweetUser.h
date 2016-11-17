//
//  TweetUser.h
//  twitter-search
//
//  Created by mcan on 16/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import <Foundation/Foundation.h>

// library
#import <Mantle/Mantle.h>


@interface TweetUser : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSURL *profileImageURL;
@property (nonatomic, copy, readonly) NSDate *createdAt;
@property (nonatomic, copy, readonly) NSNumber *id;
@property (nonatomic, copy, readonly) NSString *profileBackgroundColor;
@property (nonatomic, copy, readonly) NSString *location;
@property (nonatomic, copy, readonly) NSURL *url;
@property (nonatomic, copy, readonly) NSNumber *followersCount;
@property (nonatomic, copy, readonly) NSURL *profileBackgroundImageURL;
@property (nonatomic, copy, readonly) NSString *screenName;

@end
