//
//  MethodPlaceHolderCommand.m
//  QuickXcoder
//
//  Created by jonathan ma on 6/11/2016.
//  Copyright © 2016 jonathan ma. All rights reserved.
//

#import "MethodPlaceHolderCommand.h"

@implementation MethodPlaceHolderCommand

-(void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {
    [self addMethod:invocation];
    completionHandler(nil);
}

-(void)addMethod:(XCSourceEditorCommandInvocation *)invocation {
    NSString *identiferSuffix = [invocation.commandIdentifier componentsSeparatedByString:@"."].lastObject;
    NSString *startCharacter = [@"static" isEqualToString:identiferSuffix] ? @"+" : @"-";
    NSString *placeHolder = [startCharacter stringByAppendingString:@"(return_type"];
    NSInteger targetLineNumber = [self startLineNumberOfSelection:invocation];
    [invocation.buffer.lines insertObject:placeHolder atIndex:targetLineNumber];
    
    NSMutableArray <XCSourceTextRange *> *selections = invocation.buffer.selections;
    [selections removeAllObjects];

    NSInteger startColumn = [startCharacter stringByAppendingString:@"("].length;
    NSInteger endColumn = [startCharacter stringByAppendingString:@"(return_type"].length;
    XCSourceTextPosition startPosition = XCSourceTextPositionMake(targetLineNumber, startColumn);
    XCSourceTextPosition endPosition = XCSourceTextPositionMake(targetLineNumber, endColumn);
    XCSourceTextRange *selection = [[XCSourceTextRange alloc] initWithStart:startPosition end:endPosition];
    [selections addObject:selection];
}

@end
