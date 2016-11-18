//
//  TweetSearch.m
//  twitter-search
//
//  Created by mcan on 16/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "TweetSearch.h"

// class
#import "SearchStatuses.h"

@implementation TweetSearch

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"searchMetadata" : @"search_metadata",
             @"statuses" : @"statuses"
             };
}

+ (NSValueTransformer *)searchMetadataVariantJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:SearchMetadata.self];
}

- (NSInteger)count{
    return [self.statuses count];
}

-(void)setStatuses:(NSArray *)statuses{
    _statuses = [MTLJSONAdapter modelsOfClass:SearchStatuses.self fromJSONArray:statuses error:nil];
}

@end
