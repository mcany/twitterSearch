//
//  Formatters.m
//  twitter-search
//
//  Created by mcan on 17/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "Formatters.h"

@implementation Formatters

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:timeZone];
    dateFormatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    return dateFormatter;
}

@end
