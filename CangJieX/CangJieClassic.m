//
//  CangJieClassic.m
//  CangJieX
//
//  Created by Felix Ren-Chyan Chern on 12/1/4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CangJieClassic.h"


@implementation CangJieClassic
@synthesize trie;
@synthesize hanzi;

- (id)initWithServer:(IMKServer *)server delegate:(id)delegate client:(id)inputClient
{
    self = [super initWithServer:server delegate:delegate client:inputClient];
    if (self) {
        NSString* resource_path=[[NSBundle mainBundle] resourcePath];
        
        trie = [NSDictionary dictionaryWithContentsOfFile:[resource_path stringByAppendingPathComponent:@"cangjie_trie.plist"]];
        hanzi = [NSDictionary dictionaryWithContentsOfFile:[resource_path stringByAppendingPathComponent:@"hanzi.plist"]];
    }
    
    return self;
}

@end
