//
//  BaseCommand.m
//  QuickXcoder
//
//  Created by jonathan ma on 6/11/2016.
//  Copyright © 2016 jonathan ma. All rights reserved.
//

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

-(NSInteger)fileHeaderCommentEndLineNumber:(XCSourceEditorCommandInvocation *)invocation {
    NSMutableArray *lines = invocation.buffer.lines;
    NSInteger lineNumber = -1;
    NSString *line = [[lines objectAtIndex:0] trimWhiteSpace];
    if ([line hasPrefix:@"//"]) {
        lineNumber = [self endOfLineComment:lines startLine:0];
    } else if ([line hasPrefix:@"/*"]) {
        lineNumber = [self endOfBlockComment:lines startLine:0];
        if (lineNumber == NSNotFound) {
            [lines addObject:@"*/"];
            lineNumber = lines.count - 1;
        }
    }
    
    return lineNumber;
}

-(NSInteger)endOfLineComment:(NSArray *)lines startLine:(NSInteger)startLine {
    for (NSInteger index = startLine + 1; index < lines.count; index ++) {
        NSString *line = [[lines objectAtIndex:index] trimWhiteSpace];
        NSString *nextLine = nil;
        if (index < lines.count - 1) {
            nextLine = [[lines objectAtIndex:index + 1] trimWhiteSpace];
        }

        if ([line hasPrefix:@"//"] && ![nextLine hasPrefix:@"//"]) {
            return index;
        }
    }

    return startLine;
}

-(NSInteger)endOfBlockComment:(NSArray *)lines startLine:(NSInteger)startLine {
    for (NSInteger index = startLine + 1; index < lines.count; index ++) {
        NSString *line = [[lines objectAtIndex:index] trimWhiteSpace];
        if ([line hasSuffix:@"*/"]) {
            return index;
        }
    }
    
    return NSNotFound;
}

@end
