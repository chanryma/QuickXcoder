//
//  HeaderPlaceHolderCommand.m
//  QuickXcoder
//
//  Created by jonathan ma on 15/11/2016.
//  Copyright © 2016 jonathan ma. All rights reserved.
//

#import "HeaderPlaceHolderCommand.h"

@implementation HeaderPlaceHolderCommand

-(void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {
    NSError *error = nil;
    if ([self fileHeaderCommentEndLineNumber:invocation] != NSNotFound) {
        [self addHeaderPlaceHolder:invocation];
    }
    
    completionHandler(error);
}

-(void)addHeaderPlaceHolder:(XCSourceEditorCommandInvocation *)invocation {
    NSMutableArray *lines = invocation.buffer.lines;
    NSInteger endLineNumber = [self fileHeaderCommentEndLineNumber:invocation];
    NSString *nextLine = nil;
    if (endLineNumber == -1) {
        [lines insertObject:@"\n" atIndex:endLineNumber + 1];
    } else if (endLineNumber < lines.count - 1) {
        nextLine = [[lines objectAtIndex:endLineNumber + 1] trimWhiteSpace];
        if (!nextLine.trimWhiteSpace.isWhiteCharacterOnly) {
            [lines insertObject:@"\n" atIndex:endLineNumber + 1];
        }
    }
    
    endLineNumber = endLineNumber + 2;
    NSInteger targetLineNumber = endLineNumber;
    NSString *identiferSuffix = [invocation.commandIdentifier componentsSeparatedByString:@"."].lastObject;
    NSString *keyword = [@"import" isEqualToString:identiferSuffix] ? @"import" : @"include";
    NSString *declaration = [NSString stringWithFormat:@"#%@ \"add_header_here\"", keyword];
    [lines insertObject:declaration atIndex:targetLineNumber];
    
    NSMutableArray <XCSourceTextRange *> *selections = invocation.buffer.selections;
    [selections removeAllObjects];
    
    NSInteger startColumn = [NSString stringWithFormat:@"#%@ \"", keyword].length;
    NSInteger endColumn = [NSString stringWithFormat:@"#%@ \"add_header_here", keyword].length;
    XCSourceTextPosition startPosition = XCSourceTextPositionMake(targetLineNumber, startColumn);
    XCSourceTextPosition endPosition = XCSourceTextPositionMake(targetLineNumber, endColumn);
    XCSourceTextRange *selection = [[XCSourceTextRange alloc] initWithStart:startPosition end:endPosition];
    [selections addObject:selection];
}

@end
