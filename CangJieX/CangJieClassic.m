//
//  CangJieClassic.m
//  CangJieX
//
//  Created by Felix Ren-Chyan Chern on 12/1/4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CangJieClassic.h"

extern NSDictionary* trie;

@implementation CangJieClassic


- (id)initWithServer:(IMKServer *)server delegate:(id)delegate client:(id)inputClient
{
    self = [super initWithServer:server delegate:delegate client:inputClient];
    if (self) {
        buffer = [[NSMutableString alloc]init];
        NSLog(@"init success!");
    }
    
    return self;
}


- (BOOL) inputText:(NSString *)string client:(id)sender
{
    NSLog(@"string is %@",string);
    
    if ([string isEqualToString:@" "]) {
        [self commitComposition:sender];
        return YES;
    }
    if ([buffer length]>=5) 
        return YES;

    [buffer appendString:string];
    [sender setMarkedText:buffer selectionRange:NSMakeRange(0, [buffer length]) replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
    return YES;
}

- (BOOL) didCommandBySelector:(SEL)aSelector client:(id)sender
{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"deleteBackward:"]
        && [buffer length]>0) {
        [buffer deleteCharactersInRange:NSMakeRange([buffer length]-1, 1)];
        [sender setMarkedText:buffer selectionRange:NSMakeRange(0, [buffer length]) replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
        // setup setMarkedText and candidate
        return YES;
    }
    [sender performSelector:aSelector];
    return NO;
}


- (void) commitComposition:(id)sender
{
    NSString *exact = [[[trie objectForKey:buffer] objectForKey:@"exact"] objectAtIndex:0];
    [sender insertText:exact replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
    [buffer deleteCharactersInRange:NSMakeRange(0, [buffer length])];
}

@end
