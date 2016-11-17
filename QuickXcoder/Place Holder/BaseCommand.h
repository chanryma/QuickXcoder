//
//  BaseCommand.h
//  QuickXcoder
//
//  Created by jonathan ma on 6/11/2016.
//  Copyright © 2016 jonathan ma. All rights reserved.
//

#import <XcodeKit/XcodeKit.h>
#import "NSString+(JM).h"

@interface BaseCommand : NSObject

-(NSInteger)interfaceDeclarationLineNumber:(XCSourceEditorCommandInvocation *)invocation;
-(NSInteger)startLineNumberOfSelection:(XCSourceEditorCommandInvocation *)invocation;
-(NSInteger)fileHeaderCommentEndLineNumber:(XCSourceEditorCommandInvocation *)invocation;

@end
