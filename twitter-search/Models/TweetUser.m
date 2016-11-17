//
//  TweetUser.m
//  twitter-search
//
//  Created by mcan on 16/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "TweetUser.h"

// library
#import "MTLValueTransformer.h"

// class
#import "Formatters.h"

@implementation TweetUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"profileImageURL" : @"profile_image_url_https",
             @"createdAt" : @"created_at",
             @"id" : @"id",
             @"profileBackgroundColor" : @"profile_background_color",
             @"location" : @"location",
             @"screenName" : @"screen_name",
             @"url" : @"url",
             @"profileBackgroundImageURL" : @"profile_background_image_url_https",
             @"followersCount" : @"followers_count"
             };
}

+ (NSValueTransformer *)urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)profileImageURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)profileBackgroundImageURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)createdAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock: ^id (id value, BOOL *success, NSError *__autoreleasing *error) {
        return [Formatters.dateFormatter dateFromString:value];
    } reverseBlock: ^id (id value, BOOL *success, NSError *__autoreleasing *error) {
        return [Formatters.dateFormatter stringFromDate:value];
    }];
}

@end
