//
//  APIManager.m
//  twitter-search
//
//  Created by mcan on 16/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

#define RESULTS_PERPAGE @"100"

static NSString * const kAPIURL = @"https://api.twitter.com/1.1/";
static NSString * const searchEndpoint = @"search/tweets.json";


static NSString * const oauth_consumer_key = @"DC0sePOBbQ8bYdC8r4Smg";
static NSString * const oauth_signature_method = @"HMAC-SHA1";
static NSString * const oauth_timestamp = @"1479316572";
static NSString * const oauth_nonce = @"-151747780";
static NSString * const oauth_version = @"1.0";
static NSString * const oauth_token = @"p1aAYPGaT2BVr9e32as6ESYEv8lijyMkJegZXBld";
static NSString * const oauth_signature = @"OCmDUH1YWk4WoSOMxf4RTYAHSSk";
static NSString * const oauth = @"OAuth oauth_consumer_key=%@,oauth_signature_method=%@,oauth_timestamp=%@,oauth_nonce=%@,oauth_version=%@,oauth_token=%@,oauth_signature=%@";


static NSString * const oauthExp = @"OAuth oauth_consumer_key=\"DC0sePOBbQ8bYdC8r4Smg\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"1479316572\",oauth_nonce=\"-151747780\",oauth_version=\"1.0\",oauth_token=\"422538661-p1aAYPGaT2BVr9e32as6ESYEv8lijyMkJegZXBld\",oauth_signature=\"OCmDUH1YWk4WoSOMxf4RTYAHSSk%3D\"";

//OAuth oauth_consumer_key="DC0sePOBbQ8bYdC8r4Smg",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1479317549",oauth_nonce="3441617247",oauth_version="1.0",oauth_token="422538661-p1aAYPGaT2BVr9e32as6ESYEv8lijyMkJegZXBld",oauth_signature="AmmoySCANiMoxFN5I9UZUTRQzJk%3D"


//https://api.twitter.com/1.1/search/tweets.json?q=test

+ (NSString *)baseAPIURLString {
    return kAPIURL; //[[[NSBundle mainBundle] infoDictionary] valueForKey:@"APIBaseURLString"];
}

#pragma mark - Search
+ (RACSignal *)search:(NSString *)keyword {
    return [self GET:searchEndpoint parameters:@{@"q" : keyword}];
}

#pragma mark - Helpers
#pragma mark GET
+ (RACSignal *)GET:(NSString *)endpoint parameters:(NSDictionary *)parameters {
    
    [[APIClient sharedClient] setAuthToken:oauthExp];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
    return [RACSignal createSignal: ^RACDisposable *(id < RACSubscriber > subscriber) {
        NSURLSessionDataTask *task = [[APIClient sharedClient] GET:endpoint
                                                        parameters:params
                                                          progress:nil
                                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                               [subscriber sendNext:responseObject];
                                                               [subscriber sendCompleted];
                                                           }
                                                           failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                               [subscriber sendError:error];
                                                               
                                                           }
                                      ];
        return [RACDisposable disposableWithBlock: ^{
            [task cancel];
        }];
    }];
}

@end

@implementation APIClient : AFHTTPSessionManager

+ (instancetype)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:[APIManager baseAPIURLString]]];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.responseSerializer = [ResponseSerializer serializer];
    });
    return _sharedClient;
}

- (void)setAuthToken:(NSString *)token {
    [self.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
}

@end

@implementation ResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error {
    id JSONObject = [super responseObjectForResponse:response data:data error:error];
    if (*error != nil) {
        NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
        if (data == nil) {
            userInfo[NSLocalizedDescriptionKey] = @"";
        }
        else {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            userInfo[NSLocalizedDescriptionKey] = json[@"error"][@"message"];
            userInfo[ResponseSerializerErrorCode] = json[@"error"][@"code"];
        }
        
        NSError *newError = [NSError errorWithDomain:(*error).domain code:((NSHTTPURLResponse *)response).statusCode userInfo:userInfo];
        (*error) = newError;
    }
    
    return (JSONObject);
}

@end
