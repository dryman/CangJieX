//
//  AZCandidateWindow.m
//  CangJieX
//
//  Created by Felix Chern on 12/1/9.
//  Copyright 2012年 idryman@gmail.com. All rights reserved.
//

#import "AZCandidateWindow.h"

@implementation AZCandidateWindow

-(void) awakeFromNib {
    
    [self setBackgroundColor:[NSColor clearColor]];
    [self setAlphaValue:0.99];
    [self setOpaque:NO];
    
}

- (id) initWithContentRect:(NSRect)contentRect 
                 styleMask:(NSUInteger)aStyle
                   backing:(NSBackingStoreType)bufferingType
                     defer:(BOOL)flag
{
    self = [super initWithContentRect:contentRect
                            styleMask:aStyle
                              backing:bufferingType 
                                defer:flag];
    return self;
}


/*
-(void) displayIfNeeded {
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect: [[self contentView] bounds]
                                                         xRadius:5 yRadius:5];
    NSLog(@"display if needed, path = %@", path);
}
 */

@end
