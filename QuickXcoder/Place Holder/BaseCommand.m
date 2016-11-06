//
//  BaseCommand.m
//  QuickXcoder
//
//  Created by jonathan ma on 6/11/2016.
//  Copyright © 2016 jonathan ma. All rights reserved.
//

#import "BaseCommand.h"

@implementation BaseCommand

-(NSInteger)interfaceDeclarationLineNumber:(XCSourceEditorCommandInvocation *)invocation {
    NSMutableArray *lines = invocation.buffer.lines;
    for (NSInteger index = 0; index < lines.count; index ++) {
        if ([[lines objectAtIndex:index] hasPrefix:@"@interface"]) {
            return index;
        }
    }

    return NSNotFound;
}

-(NSInteger)startLineNumberOfSelection:(XCSourceEditorCommandInvocation *)invocation {
    NSMutableArray <XCSourceTextRange *> *selections = invocation.buffer.selections;
    return [selections objectAtIndex:0].start.line;
}

@end
