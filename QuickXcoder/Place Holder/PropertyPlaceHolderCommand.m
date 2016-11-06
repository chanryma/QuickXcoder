//
//  PropertyPlaceHolderCommand.m
//  QuickCoder
//
//  Created by jonathan ma on 5/11/2016.
//  Copyright © 2016 jonathan ma. All rights reserved.
//

#import "PropertyPlaceHolderCommand.h"

@implementation PropertyPlaceHolderCommand

-(void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {
    NSError *error = nil;
    if ([self interfaceDeclarationLineNumber:invocation] != NSNotFound) {
        [self addPropertyDeclaration:invocation];
    } else {
        error = [NSError errorWithDomain:@"You can only perform this action in an interface declaration." code:-1 userInfo:nil];
    }

    completionHandler(error);
}

-(void)addPropertyDeclaration:(XCSourceEditorCommandInvocation *)invocation {
    NSInteger interfaceDeclarationLineNumber = [self interfaceDeclarationLineNumber:invocation];
    NSMutableArray *lines = invocation.buffer.lines;
    NSString *targetLineContent = [lines objectAtIndex:(interfaceDeclarationLineNumber + 1)];
    if (![targetLineContent isWhiteCharacterOnly]) { // there is not a blank line under interface declaration, add one
        [lines insertObject:@"\n" atIndex:(interfaceDeclarationLineNumber + 1)];
    }

    NSInteger targetLineNumber = interfaceDeclarationLineNumber + 2;
    NSString *declaration = @"@property (nonatomic, relation";
    [lines insertObject:declaration atIndex:targetLineNumber];
    
    NSMutableArray <XCSourceTextRange *> *selections = invocation.buffer.selections;
    [selections removeAllObjects];

    NSInteger startColumn = @"@property (nonatomic, ".length;
    NSInteger endColumn = @"@property (nonatomic, relation".length;
    XCSourceTextPosition startPosition = XCSourceTextPositionMake(targetLineNumber, startColumn);
    XCSourceTextPosition endPosition = XCSourceTextPositionMake(targetLineNumber, endColumn);
    XCSourceTextRange *selection = [[XCSourceTextRange alloc] initWithStart:startPosition end:endPosition];
    [selections addObject:selection];
}

@end

