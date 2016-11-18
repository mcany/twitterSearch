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

+ (RACSignal *)refreshToken;
+ (RACSignal *)search:(NSString *)keyword;
+ (RACSignal *)searchNext:(NSString *)url;

@end


@interface APIClient : AFHTTPSessionManager
@property (strong, nonatomic) NSString *token;
@property (nonatomic) BOOL isRefreshed;

+ (instancetype)sharedClient;
- (void)setAuthorizationOauthHeader;
- (void)setAuthorizationBasicHeader;
- (void)setAuthorizationBearerHeader;
- (NSString *) twitterAuthorizationBasichHeader;
@end
/// NSError userInfo key that will contain response data
static NSString *const ResponseSerializerKey = @"ResponseSerializerKey";
static NSString *const ResponseSerializerErrorCode = @"ResponseSerializerErrorCode";
@interface ResponseSerializer : AFJSONResponseSerializer
@end
