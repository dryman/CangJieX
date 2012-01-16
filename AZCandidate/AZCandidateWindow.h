//
//  AZCandidateWindow.h
//  CangJieX
//
//  Created by Felix Chern on 12/1/9.
//  Copyright 2012年 idryman@gmail.com. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface AZCandidateWindow : NSWindow {
    NSView* _view;
    NSRect _viewFrame;
    NSPoint _origin;
    CGFloat xMargin; // should be zero
    CGFloat yMargin;
}

-(AZCandidateWindow*) initWithView:(NSView*) view andOrigin:(NSPoint)point;

@end
