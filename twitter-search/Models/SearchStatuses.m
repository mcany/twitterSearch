//
//  SearchStatuses.m
//  twitter-search
//
//  Created by mcan on 16/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "SearchStatuses.h"

// library
#import "MTLValueTransformer.h"

// class
#import "Formatters.h"

@implementation SearchStatuses

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"id" : @"id",
             @"source" : @"source",
             @"favoriteCount" : @"favorite_count",
             @"lang" : @"lang",
             @"retweetCount" : @"retweet_count",
             @"favorited" : @"favorited",
             @"retweeted" : @"retweeted",
             @"text" : @"text",
             @"createdAt" : @"created_at",
             @"user" : @"user"
             };
}

+ (NSValueTransformer *)userVariantJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:TweetUser.class];
}

+ (NSValueTransformer *)createdAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock: ^id (id value, BOOL *success, NSError *__autoreleasing *error) {
        return [Formatters.dateFormatter dateFromString:value];
    } reverseBlock: ^id (id value, BOOL *success, NSError *__autoreleasing *error) {
        return [Formatters.dateFormatter stringFromDate:value];
    }];
}

@end
