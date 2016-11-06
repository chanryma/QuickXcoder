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

    NSString *identiferSuffix = [invocation.commandIdentifier componentsSeparatedByString:@"."].lastObject;
    NSString *propertyDeclaration = [self propertyDeclarationForType:identiferSuffix];
    [lines insertObject:propertyDeclaration atIndex:(interfaceDeclarationLineNumber + 2)];
}

-(NSString *)propertyDeclarationForType:(NSString *)key {
    NSDictionary *keys2Values = @{
                                  @"strong" : @"strong",
                                  @"weak" : @"weak",
                                  @"assign" : @"assign",
                                  @"copy" : @"copy",
                                  @"retain" : @"retain"
                                  };

    return [NSString stringWithFormat:@"@property (nonatomic, %@) ", [keys2Values objectForKey:key]];
}

@end

