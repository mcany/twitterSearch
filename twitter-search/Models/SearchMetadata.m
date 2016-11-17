//
//  SearchMetadata.m
//  twitter-search
//
//  Created by mcan on 16/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "SearchMetadata.h"

@implementation SearchMetadata

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"count" : @"count",
             @"query" : @"query",
             @"nextResults" : @"next_results",
             @"refreshURL" : @"refresh_url"
             };
}

@end
