//
//  AZCandidateAppDelegate.m
//  AZCandidate
//
//  Created by Felix Ren-Chyan Chern on 12/1/7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "AZCandidateAppDelegate.h"

@implementation AZCandidateAppDelegate
@synthesize window;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /*
    window = [[AZCandidateWindow alloc] initWithContentRect:NSMakeRect(100, 300, 0, 0) 
                                                  styleMask:NSBorderlessWindowMask 
                                                    backing:NSBackingStoreBuffered 
                                                      defer:YES];
    [window makeKeyAndOrderFront:NSApp];
    [window setContentView:table_view];
    [window setContentSize:NSMakeSize(400, 680)];
     */
    // Insert code here to initialize your application
    NSLog(@"finish launching");
    //NSSize size = [[[[window contentView] subviews] objectAtIndex:0] contentSize];
    //NSLog(@"size of nstable is %@",size);
}
- (void)dealloc {
    [window release];
    [super dealloc];
}

@end
