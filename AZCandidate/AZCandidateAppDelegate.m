//
//  AZCandidateAppDelegate.m
//  AZCandidate
//
//  Created by Felix Ren-Chyan Chern on 12/1/7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "AZCandidateAppDelegate.h"

@implementation AZCandidateAppDelegate
@synthesize table_view;
@synthesize original_key;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    window = [[AZCandidateWindow alloc] initWithContentRect:NSMakeRect(100, 300, 0, 0) 
                                                  styleMask:NSBorderlessWindowMask 
                                                    backing:NSBackingStoreBuffered 
                                                      defer:YES];
    [window makeKeyAndOrderFront:NSApp];
    [window setContentView:table_view];
    [window setContentSize:NSMakeSize(400, 680)];
    
    // Insert code here to initialize your application
    NSString* resource_path=[[NSBundle mainBundle] resourcePath];
    trie = [[NSDictionary alloc] initWithContentsOfFile:[resource_path stringByAppendingPathComponent:@"cangjie_trie.plist"]];
    keyname = [[NSDictionary alloc] initWithContentsOfFile:[resource_path stringByAppendingPathComponent:@"cangjie_keyname.plist"]];
    _words = [NSMutableArray new];
    self.original_key = @"hap";
    [_words addObjectsFromArray:[[trie objectForKey:original_key] objectForKey:@"exact"]];
    [_words addObjectsFromArray:[[trie objectForKey:original_key] objectForKey:@"identical"]];
    [_words addObjectsFromArray:[[trie objectForKey:original_key] objectForKey:@"further"]];
    [table_view reloadData];
    
    
    NSLog(@"finish launching");
}
- (void)dealloc {
    [_words release];
    [trie release];
    [keyname release];
    [window release];
    [super dealloc];
}
- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView{
    NSInteger count=0;
    count += [_words count];
    return count;
}
- (NSView*) tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTextField *textView = [tableView makeViewWithIdentifier:@"MainCell" owner:self];
    if (textView == nil) {
        textView = [[[NSTextField alloc] initWithFrame:NSZeroRect] autorelease];
        textView.identifier = @"MainCell";
    }
    textView.stringValue = [_words objectAtIndex:row];
    return textView;
}

@end
