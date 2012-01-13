//
//  AZCandidateAppDelegate.h
//  AZCandidate
//
//  Created by Felix Ren-Chyan Chern on 12/1/7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AZCandidateWindow.h"

@interface AZCandidateAppDelegate : NSObject <NSApplicationDelegate> {
    // AZCandidateWindow *window;
    // May change NSWindow to AZCandidateWindow, then no need of NSWindow in MainMenu in xib file
    //NSTableView *table_view;
    NSWindow *window;
}
//@property (assign) IBOutlet NSTableView *table_view;
@property (assign) IBOutlet NSWindow *window;


@end
