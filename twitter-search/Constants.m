//
//  Constants.m
//  twitter-search
//
//  Created by mcan on 16/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "Constants.h"

@implementation Constants

+ (NSString*)tweetsListCellCellTypeToString:(TweetsListCell)cellType {
    NSString *result = nil;
    switch(cellType) {
        case TweetsListCell1:
            result = @"TweetsListCell1";
            break;
        case TweetsListCell2:
            result = @"TweetsListCell1";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    return result;
}

@end
