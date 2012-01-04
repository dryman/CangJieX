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



@implementation CangJieXTests

- (void)setUp
{
    [super setUp];
    cc = [[CangJieClassic alloc] initWithServer:Nil delegate:Nil client:Nil];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    [cc release];
    [super tearDown];
}

- (void)testTrie
{
    NSString* hapi = [[[cc.trie objectForKey:@"hapi"] objectForKey:@"exact"] objectAtIndex:0];
    STAssertTrue([hapi isEqualToString:@"的"],@"load trie ok");
}
- (void)testHanzi
{
    NSString* hapi = [[[cc.trie objectForKey:@"hapi"] objectForKey:@"exact"] objectAtIndex:0];
    NSDictionary* hapi_hanzi = [cc.hanzi objectForKey:hapi];
    NSString* cangjie = [[hapi_hanzi objectForKey:@"cangjie"] objectAtIndex:0];
    STAssertTrue([cangjie isEqualToString:@"hapi"],@"reverse find cangjie code ok");

}

@end
