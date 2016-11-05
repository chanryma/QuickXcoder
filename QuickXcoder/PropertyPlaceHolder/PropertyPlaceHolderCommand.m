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
    NSString *fileType = invocation.buffer.contentUTI;
    NSString *identifier = invocation.commandIdentifier;
    NSLog(@"fileType=%@, identifier=%@", fileType, identifier);
    [self addPropertyDeclaration:invocation];
    
    completionHandler(nil);
}

-(void)addPropertyDeclaration:(XCSourceEditorCommandInvocation *)invocation {
    NSMutableArray *lines = invocation.buffer.lines;
    NSInteger interfaceDeclarationLineNumber = [self interfaceDeclarationLineNumber:lines];
    if (interfaceDeclarationLineNumber == NSNotFound) {
        return;
    }

    NSString *targetLineContent = [lines objectAtIndex:(interfaceDeclarationLineNumber + 1)];
    targetLineContent = [targetLineContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    targetLineContent = [targetLineContent stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    if (targetLineContent.length != 0) { // there is not a blank line under interface declaration, add one
        [lines insertObject:@"\n" atIndex:(interfaceDeclarationLineNumber + 1)];
    }

    NSString *identiferSuffix = [invocation.commandIdentifier componentsSeparatedByString:@"."].lastObject;
    NSString *propertyDeclaration = [self propertyDeclarationForType:identiferSuffix];
    [lines insertObject:propertyDeclaration atIndex:(interfaceDeclarationLineNumber + 2)];
}

-(NSInteger)interfaceDeclarationLineNumber:(NSArray<NSString *> *)lines {
    for (NSInteger index = 0; index < lines.count; index ++) {
        if ([[lines objectAtIndex:index] hasPrefix:@"@interface"]) {
            return index;
        }
    }
    
    return NSNotFound;
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

