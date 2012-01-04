//
//  CangJieClassic.m
//  CangJieX
//
//  Created by Felix Ren-Chyan Chern on 12/1/4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CangJieClassic.h"


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
    if (!buffer)
        NSLog(@"didn't get buffer!");
    else {
        NSLog(@"we have buffer");
        NSLog(@"%@",buffer);
        [buffer appendString:string];
    }
        //buffer = [[NSMutableString alloc] initWithCapacity:6];
    //NSLog(@"retain count of buffer is %@",[buffer retainCount]);

    /*if ([buffer length]>=5) 
        return NO;
    // if ([string isEqualToString:@" "]) [self commitComposition:sender];

    [buffer appendString:string];
     
    [sender setMarkedText:string selectedRange:NSMakeRange([buffer length], 0) replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
     */
    return YES;
}
/*
- (BOOL) didCommandBySelector:(SEL)aSelector client:(id)sender
{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"deleteBackward:"]
        && [buffer length]>1) {
        [buffer deleteCharactersInRange:NSMakeRange([buffer length]-1, 1)];
        // setup setMarkedText and candidate
        return YES;
    }
    return NO;
}


- (void) commitComposition:(id)sender
{
    NSString *exact = [[[trie objectForKey:buffer] objectForKey:@"exact"] objectAtIndex:0];
    [sender insertText:exact replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
}
*/
@end
