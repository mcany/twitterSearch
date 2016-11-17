//
//  SearchMetadata.h
//  twitter-search
//
//  Created by mcan on 16/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import <Foundation/Foundation.h>

// library
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface SearchMetadata : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *count;
@property (nonatomic, copy, readonly) NSString *query;
@property (nonatomic, copy, readonly) NSString *nextResults;
@property (nonatomic, copy, readonly) NSString *refreshURL;

@end
