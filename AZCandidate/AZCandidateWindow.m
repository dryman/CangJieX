//
//  AZCandidateWindow.m
//  CangJieX
//
//  Created by Felix Chern on 12/1/9.
//  Copyright 2012年 idryman@gmail.com. All rights reserved.
//

#import "AZCandidateWindow.h"

@interface AZCandidateWindow (AZCandidatePrivate)

-(void) _updateGeometry;

@end

@implementation AZCandidateWindow

-(AZCandidateWindow*) initWithView:(NSView*) view andOrigin:(NSPoint) point{
    if (!view) return nil;
    self = [super initWithContentRect:NSZeroRect 
                            styleMask:NSBorderlessWindowMask 
                              backing:NSBackingStoreBuffered 
                                defer:NO];
    if (self) {
        _view = view;
        _origin = point;
        [self setBackgroundColor:[NSColor clearColor]];
        [self setMovableByWindowBackground:NO];
        [self setAlphaValue:1.0];
        [self setOpaque:NO];
        [self setHasShadow:YES];
        [self useOptimizedDrawing:YES]; // not sure
        [[self contentView] addSubview:_view];
    }
    return self;
}

-(void) _updateGeometry{
    CGFloat _view_width = _view.frame.size.width;
    CGFloat _view_height = _view.frame.size.height;
    NSRect contentRect = NSMakeRect(_origin.x, _origin.y, _view_width, _view_height);
    
    _viewFrame = NSMakeRect(xMargin, yMargin, _view_width, _view_height);
    contentRect = NSInsetRect(contentRect, -xMargin, -yMargin);
    
    [self setFrame:contentRect display:NO];
    [_view setFrame:_viewFrame];
}

@end
