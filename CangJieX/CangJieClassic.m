//
//  CangJieClassic.m
//  CangJieX
//
//  Created by Felix Ren-Chyan Chern on 12/1/4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CangJieClassic.h"

extern NSDictionary* trie;
extern NSDictionary* keyname;

@implementation CangJieClassic


- (id)initWithServer:(IMKServer *)server delegate:(id)delegate client:(id)inputClient
{
    self = [super initWithServer:server delegate:delegate client:inputClient];
    if (self) {
        _originalBuffer = [[NSMutableString alloc] init];
        _composedBuffer = [[NSMutableString alloc] init];
        NSLog(@"init success!");
    }
    return self;
}


- (BOOL) inputText:(NSString *)string client:(id)sender
{
    NSLog(@"string is %@",string);
    
    // Need to deal when string is not in set of key_name
    if ([string isEqualToString:@" "]) {
        [self commitComposition:sender];
        return YES;
    }
    if ([_originalBuffer length]>=5) 
        return YES;

    [_originalBuffer appendString:string];
    [_composedBuffer appendString:[keyname objectForKey:string]];
    [sender setMarkedText:_composedBuffer 
           selectionRange:NSMakeRange(0, [_originalBuffer length]) 
         replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
    return YES;
}

- (BOOL) didCommandBySelector:(SEL)aSelector client:(id)sender
{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"deleteBackward:"]
        && [_originalBuffer length]>0) {
        [_originalBuffer deleteCharactersInRange:NSMakeRange([_originalBuffer length]-1, 1)];
        [_composedBuffer deleteCharactersInRange:NSMakeRange([_composedBuffer length]-1, 1)];
        [sender setMarkedText:_composedBuffer 
               selectionRange:NSMakeRange(0, [_originalBuffer length]) 
             replacementRange:NSMakeRange(NSNotFound, NSNotFound)];        
        // setup candidate
        return YES;
    }
    [sender performSelector:aSelector];
    return NO;
}


- (void) commitComposition:(id)sender
{
    NSString *exact = [[[trie objectForKey:_originalBuffer] objectForKey:@"exact"] objectAtIndex:0];
    if (exact) {
        [sender insertText:exact replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
        [_originalBuffer deleteCharactersInRange:NSMakeRange(0, [_originalBuffer length])];
        [_composedBuffer deleteCharactersInRange:NSMakeRange(0, [_composedBuffer length])];
    }
}

@end
