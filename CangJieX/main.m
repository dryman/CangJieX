//
//  main.m
//  CangJieX
//
//  Created by Felix Ren-Chyan Chern on 11/12/4.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <InputMethodKit/InputMethodKit.h>

const NSString* connectionName=@"AzaleaCangJie_1_Connection";
IMKServer* server;

int main(int argc, char *argv[])
{
    NSString*       identifier;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	//find the bundle identifier and then initialize the input method server
    identifier = [[NSBundle mainBundle] bundleIdentifier];
    server = [[IMKServer alloc] initWithName:(NSString*)connectionName bundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]];
    NSArray *arr = [NSConnection allConnections];
    for (NSConnection* connection in arr){
        NSLog(@"%@",connection);
    }
	
    //load the bundle explicitly because in this case the input method is a background only application 
	[NSBundle loadNibNamed:@"MainMenu" owner:[NSApplication sharedApplication]];
	
	//finally run everything
	[[NSApplication sharedApplication] run];
	
    [pool release];
}
