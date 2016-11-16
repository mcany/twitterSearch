//
//  Constants.h
//  twitter-search
//
//  Created by mcan on 16/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

#pragma Mark - Cell
typedef NS_ENUM(NSInteger,TweetsListCell) {
    TweetsListCell1,
    TweetsListCell2
};

+ (NSString*)tweetsListCellCellTypeToString:(TweetsListCell)cellType;

@end
