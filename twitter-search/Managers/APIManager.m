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
static NSString * const oauthBase64Header = @"Basic NWJjcFFXa2RKZVFQNENQdlZ4SG9OdjhrdTpvWGtTYXVVcnBtNFhvWmhvTXVVSWVHTURneFZnVFRxemhxeFJPdzJZYURmd05jQm5VTg==";

static NSString * const kAPIURL = @"https://api.twitter.com";
static NSString * const searchEndpoint = @"/1.1/search/tweets.json";

static NSString * const oauthEndpoint = @"/oauth2/token";


//static NSString * const oauthExp = @"OAuth oauth_consumer_key=\"DC0sePOBbQ8bYdC8r4Smg\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"1479316572\",oauth_nonce=\"-151747780\",oauth_version=\"1.0\",oauth_token=\"422538661-p1aAYPGaT2BVr9e32as6ESYEv8lijyMkJegZXBld\",oauth_signature=\"OCmDUH1YWk4WoSOMxf4RTYAHSSk%3D\"";

//OAuth oauth_consumer_key="DC0sePOBbQ8bYdC8r4Smg",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1479317549",oauth_nonce="3441617247",oauth_version="1.0",oauth_token="422538661-p1aAYPGaT2BVr9e32as6ESYEv8lijyMkJegZXBld",oauth_signature="AmmoySCANiMoxFN5I9UZUTRQzJk%3D"


//https://api.twitter.com/1.1/search/tweets.json?q=test

+ (NSString *)baseAPIURLString {
    return kAPIURL; //[[[NSBundle mainBundle] infoDictionary] valueForKey:@"APIBaseURLString"];
}

#pragma mark - Search
+ (RACSignal *)search:(NSString *)keyword {
    return [self GET:searchEndpoint parameters:@{@"q" : keyword}];
}

+ (RACSignal *)searchNext:(NSString *)url {
    return [self GET:[NSString stringWithFormat:@"%@%@",searchEndpoint,url] parameters:nil];
}

+ (RACSignal *)refreshToken {
    NSURL *baseAPIURL = [NSURL URLWithString:[APIManager baseAPIURLString]];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseAPIURL];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:oauthBase64Header forHTTPHeaderField:@"Authorization"];
    NSDictionary *parametersDictionary = @{@"grant_type" : @"client_credentials"};
    
    return [RACSignal createSignal: ^RACDisposable *(id < RACSubscriber > subscriber) {
        if ([APIClient sharedClient].isRefreshed) {
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock: ^{
            }];
        }
        [APIClient sharedClient].isRefreshed = true;
        NSURLSessionDataTask *task =  [manager POST:oauthEndpoint parameters:parametersDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [[APIClient sharedClient] setToken:responseObject[@"access_token"]];
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock: ^{
            [task cancel];
        }];
    }];
}

#pragma mark - Helpers
#pragma mark GET
+ (RACSignal *)GET:(NSString *)endpoint parameters:(NSDictionary *)parameters {
    return  [[self refreshToken] flattenMap:^RACStream *(id value) {
        if(value){
            [[APIClient sharedClient] setToken:value[@"access_token"]];
        }
        [[APIClient sharedClient] setAuthorizationBearerHeader];
        return [self GETWithHeaderAdded:endpoint parameters:parameters];

             }];
}

+ (RACSignal *)GETWithHeaderAdded:(NSString *)endpoint parameters:(NSDictionary *)parameters {
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

+ (RACSignal *)POST:(NSString *)endpoint parameters:(NSDictionary *)parameters {
    [[APIClient sharedClient] setAuthorizationOauthHeader];
    return [self POSTWithHeaderAdded:endpoint parameters:parameters];
}

+ (RACSignal *)POSTWithHeaderAdded:(NSString *)endpoint parameters:(NSDictionary *)parameters {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
    return [RACSignal createSignal: ^RACDisposable *(id < RACSubscriber > subscriber) {
        NSURLSessionDataTask *task = [[APIClient sharedClient] POST:endpoint
                                                         parameters:params
                                                           progress:nil
                                                            success: ^(NSURLSessionDataTask *task, id responseObject) {
                                                                [subscriber sendNext:responseObject];
                                                                [subscriber sendCompleted];
                                                            }
                                                            failure: ^(NSURLSessionDataTask *task, NSError *error) {
                                                                [subscriber sendError:error];
                                                            }];
        return [RACDisposable disposableWithBlock: ^{
            [task cancel];
        }];
    }];
}

@end

@implementation APIClient : AFHTTPSessionManager

//NSString * const oauth_consumer_key = @"DC0sePOBbQ8bYdC8r4Smg";
NSString * const oauthSignatureMethod = @"HMAC-SHA1";
NSString * const oauthBase64 = @"Basic NWJjcFFXa2RKZVFQNENQdlZ4SG9OdjhrdTpvWGtTYXVVcnBtNFhvWmhvTXVVSWVHTURneFZnVFRxemhxeFJPdzJZYURmd05jQm5VTg==";
//NSString * const oauth_timestamp = @"1479316572";
NSString * const oauthNonce = @"-151747780";
NSString * const oauthVersion = @"1.0";
//NSString * const oauth_token = @"p1aAYPGaT2BVr9e32as6ESYEv8lijyMkJegZXBld";
//NSString * const oauth_signature = @"OCmDUH1YWk4WoSOMxf4RTYAHSSk";
NSString * const oauth = @"OAuth oauth_consumer_key=%@,oauth_signature_method=%@,oauth_timestamp=%@,oauth_nonce=%@,oauth_version=%@,oauth_token=%@,oauth_signature=%@";
NSString * const basic = @"Basic %@";
NSString * const bearer = @"Bearer %@";


+ (instancetype)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:[APIManager baseAPIURLString]]];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        [_sharedClient.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];

        _sharedClient.responseSerializer = [ResponseSerializer serializer];
        _sharedClient.token = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"twitterToken"];
    });
    return _sharedClient;
}

- (void)setAuthorizationBasicHeader {
    [self.requestSerializer setValue:[self twitterAuthorizationBasichHeader] forHTTPHeaderField:@"Authorization"];
}

- (void)setAuthorizationOauthHeader {
    [self.requestSerializer setValue:[self twitterAuthorizationOauthHeader] forHTTPHeaderField:@"Authorization"];
}

- (void)setAuthorizationBearerHeader {
    [self.requestSerializer setValue:[self twitterAuthorizationBearerHeader] forHTTPHeaderField:@"Authorization"];
}

- (NSString *) twitterAuthorizationBearerHeader{
    return [NSString stringWithFormat:bearer, [self token]];
}

- (NSString *) twitterAuthorizationBasichHeader{
    return [NSString stringWithFormat:basic, [self twitterBaiscBase64]];
}

- (NSString *) twitterBaiscBase64{
    return oauthBase64;
}

- (NSString *) twitterAuthorizationOauthHeader{
    return [NSString stringWithFormat:oauth,
            [self twitterOauthConsumerKey],
            [self twitterOauthSignatureMethod],
            [self twitterOauthTimestamp],
            [self twitterOauthNonce],
            [self twitterOauthVersion],
            [self twitterOauthToken],
            [self twitterOauthSignature]
            ];
}

- (NSString *) twitterOauthConsumerKey{
    return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"twitterConsumerKey"];
}

- (NSString *) twitterOauthSignatureMethod{
    return oauthSignatureMethod;
}

- (NSString *) twitterOauthTimestamp{
    return  [NSString stringWithFormat:@"%lu", (unsigned long)[NSDate.date timeIntervalSince1970]];
}

- (NSString *) twitterOauthNonce{
    return oauthNonce;
}

- (NSString *) twitterOauthVersion{
    return oauthVersion;
}

- (NSString *) twitterOauthToken{
    return self.token;
}

- (NSString *) twitterOauthSignature{
    return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"twitterSignature"];
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
