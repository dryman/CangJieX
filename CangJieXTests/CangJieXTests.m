//
//  CangJieXTests.m
//  CangJieXTests
//
//  Created by Felix Ren-Chyan Chern on 12/1/1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "CangJieClassic.h"

@interface CangJieXTests : SenTestCase{
    CangJieClassic *cc;
}

@end

NSDictionary *trie;
NSDictionary *hanzi;

@implementation CangJieXTests

- (void)setUp
{
    [super setUp];
    NSString* resource_path=[[NSBundle mainBundle] resourcePath];
    trie = [[NSDictionary alloc] initWithContentsOfFile:[resource_path stringByAppendingPathComponent:@"cangjie_trie.plist"]];
    hanzi = [[NSDictionary alloc] initWithContentsOfFile:[resource_path stringByAppendingPathComponent:@"hanzi.plist"]];
    cc = [[CangJieClassic alloc] initWithServer:Nil delegate:Nil client:Nil];
	
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    [cc release];
    [trie release];
    [hanzi release];
    [super tearDown];
}

- (void)testTrie
{
    NSString* hapi = [[[trie objectForKey:@"hapi"] objectForKey:@"exact"] objectAtIndex:0];
    STAssertTrue([hapi isEqualToString:@"的"],@"load trie ok");
}
- (void)testHanzi
{
    NSString* hapi = [[[trie objectForKey:@"hapi"] objectForKey:@"exact"] objectAtIndex:0];
    NSDictionary* hapi_hanzi = [hanzi objectForKey:hapi];
    NSString* cangjie = [[hapi_hanzi objectForKey:@"cangjie"] objectAtIndex:0];
    STAssertTrue([cangjie isEqualToString:@"hapi"],@"reverse find cangjie code ok");

}


@end
