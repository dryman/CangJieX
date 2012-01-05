//
//  main.m
//  CangJieX
//
//  Created by Felix Ren-Chyan Chern on 11/12/4.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <InputMethodKit/InputMethodKit.h>

const NSString* connectionName=@"AzaleaCangjie_1_Connection";
IMKServer* server;
NSDictionary *trie;
NSDictionary *hanzi;
NSDictionary *keyname;

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	//find the bundle identifier and then initialize the input method server
    server = [[IMKServer alloc] initWithName:(NSString*)connectionName bundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]];
    NSArray *arr = [NSConnection allConnections];
    for (NSConnection* connection in arr){
        NSLog(@"%@",connection);
    }
    NSString* resource_path=[[NSBundle mainBundle] resourcePath];
    trie = [[NSDictionary alloc] initWithContentsOfFile:[resource_path stringByAppendingPathComponent:@"cangjie_trie.plist"]];
    hanzi = [[NSDictionary alloc] initWithContentsOfFile:[resource_path stringByAppendingPathComponent:@"hanzi.plist"]];
    keyname = [[NSDictionary alloc] initWithContentsOfFile:[resource_path stringByAppendingPathComponent:@"cangjie_keyname.plist"]];
	
    //load the bundle explicitly because in this case the input method is a background only application 
	[NSBundle loadNibNamed:@"MainMenu" owner:[NSApplication sharedApplication]];
	
	//finally run everything
	[[NSApplication sharedApplication] run];
    
    
	[trie release];
    [hanzi release];
    [keyname release];
    [pool drain];
}
