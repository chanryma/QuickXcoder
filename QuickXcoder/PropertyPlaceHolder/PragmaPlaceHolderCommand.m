//
//  PragmaPlaceHolderCommand.m
//  QuickXcoder
//
//  Created by jonathan ma on 6/11/2016.
//  Copyright © 2016 jonathan ma. All rights reserved.
//

#import "PragmaPlaceHolderCommand.h"

@implementation PragmaPlaceHolderCommand

-(void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {
    [self addPragma:invocation];
    completionHandler(nil);
}

-(void)addPragma:(XCSourceEditorCommandInvocation *)invocation {
    NSString *placeHolder = @"#pragma mark- Add_Your_Section_Title";
    NSInteger targetLineNumber = [self startLineNumberOfSelection:invocation];
    [invocation.buffer.lines insertObject:placeHolder atIndex:targetLineNumber];

    NSMutableArray <XCSourceTextRange *> *selections = invocation.buffer.selections;
    [selections removeAllObjects];

    NSInteger startColumn = @"#pragma mark- ".length;
    NSInteger endColumn = @"#pragma mark- Add_Your_Section_Title".length;
    XCSourceTextPosition startPosition = XCSourceTextPositionMake(targetLineNumber, startColumn);
    XCSourceTextPosition endPosition = XCSourceTextPositionMake(targetLineNumber, endColumn);
    XCSourceTextRange *selection = [[XCSourceTextRange alloc] initWithStart:startPosition end:endPosition];
    [selections addObject:selection];
}

@end
