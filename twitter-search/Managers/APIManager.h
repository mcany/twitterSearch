//
//  APIManager.h
//  twitter-search
//
//  Created by mcan on 16/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import <Foundation/Foundation.h>

// Library
#import "AFHTTPSessionManager.h"
#import "ReactiveCocoa.h"

@interface APIManager : NSObject

+ (RACSignal *)search:(NSString *)keyword;

@end


@interface APIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
- (void)setAuthToken:(NSString *)token;
@end
/// NSError userInfo key that will contain response data
static NSString *const ResponseSerializerKey = @"ResponseSerializerKey";
static NSString *const ResponseSerializerErrorCode = @"ResponseSerializerErrorCode";
@interface ResponseSerializer : AFJSONResponseSerializer
@end
