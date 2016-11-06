//
//  NSString+(JM).m
//  QuickXcoder
//
//  Created by jonathan ma on 6/11/2016.
//  Copyright © 2016 jonathan ma. All rights reserved.
//

#import "NSString+(JM).h"

@implementation NSString(JM)

-(BOOL)isWhiteCharacterOnly {
    NSString *content = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    content = [self stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];

    return (content.length == 0);
}

@end
