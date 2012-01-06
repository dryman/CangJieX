//
//  main.m
//  BuildCangJieTrie
//
//  Created by Felix Ren-Chyan Chern on 12/1/4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDFileReader.h"
#define MACRO_VALUE_TO_STRING_( m ) #m
#define MACRO_VALUE_TO_STRING( m ) MACRO_VALUE_TO_STRING_( m )

int main (int argc, const char * argv[])
{

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSLog(@"start init");
    NSMutableArray *cj5_key = [NSMutableArray arrayWithCapacity:30];
    NSMutableArray *cj5_keyname = [NSMutableArray arrayWithCapacity:30];
    NSMutableArray *cj5_def = [NSMutableArray arrayWithCapacity:70000];
    NSMutableArray *cj5_char = [NSMutableArray arrayWithCapacity:70000];
    
    NSString *data_path = @""
    MACRO_VALUE_TO_STRING(SRC_ROOT)
    "/data";
    
    // Read cangjie.cin
    NSString *line;
    DDFileReader *reader = [[DDFileReader alloc] initWithFilePath:
                            [data_path stringByAppendingPathComponent:@"cangjie.cin"]];
    // Read keycode
    while ((line = [reader readChompedLine:1])) {
        NSLog(@"%@",line);
        if ([line isEqualToString:@"\%keyname begin"]) break;
    }
    while ((line = [reader readChompedLine:1])){
        NSLog(@"%@",line);
        if ([line isEqualToString:@"\%keyname end"]) break;
        NSArray *pair = [line componentsSeparatedByString:@" "];
        [cj5_key addObject:[pair objectAtIndex:0]];
        [cj5_keyname addObject:[pair objectAtIndex:1]];
    }
    // Read char def
    while ((line = [reader readChompedLine:1])){
        if ([[line substringToIndex:1] isEqualToString:@"%"] ||
            [[line substringToIndex:1] isEqualToString:@"#"]){ // skip lines with prefix % and #
            continue;
        }
        NSArray *pair = [line componentsSeparatedByString:@" "];
        [cj5_def addObject:[pair objectAtIndex:0]];
        [cj5_char addObject:[pair objectAtIndex:1]];
    }
    [reader release];
    
    NSDictionary *keyname_dict = [NSDictionary dictionaryWithObjects:cj5_keyname forKeys:cj5_key];
    
    NSMutableArray *trie_attrs = [NSMutableArray arrayWithCapacity:70000];
    for (NSString *def in cj5_def){
        NSMutableArray* e = [NSMutableArray arrayWithCapacity:2];
        NSMutableArray* i = [NSMutableArray arrayWithCapacity:2];
        NSMutableArray* f = [NSMutableArray arrayWithCapacity:10];
        NSArray* keys = [NSArray arrayWithObjects:@"exact",@"identical",@"further", nil];
        NSArray* objs = [NSArray arrayWithObjects: e, i, f, nil];
        [trie_attrs addObject:[NSDictionary dictionaryWithObjects: objs forKeys: keys]];
    }
    NSMutableDictionary *trie = [NSMutableDictionary dictionaryWithObjects:trie_attrs forKeys:cj5_def];
    NSLog(@"trie inited");

    int num = (int) [cj5_def count];

    for (int i=0; i<num; ++i){
        // rule 1: add to exact
        NSString *exact_def = [cj5_def objectAtIndex:i];
        NSString *zh = [cj5_char objectAtIndex:i];
        
        [[[trie objectForKey:exact_def] 
          objectForKey:@"exact"] 
         addObject:zh];
        
        // rule 2: length = 1, continue
        if ([exact_def length] ==1) continue;
        // rule 3: for idx = 2 to lenth-1, add to further
        for (NSUInteger idx = 2; idx < [exact_def length]-1; ++idx){
            NSString *further_def = [exact_def substringToIndex:idx];
            NSDictionary *trie_obj = [trie objectForKey:further_def];
            if (!trie_obj){
                NSMutableArray* e = [NSMutableArray arrayWithCapacity:1];
                NSMutableArray* i = [NSMutableArray arrayWithCapacity:1];
                NSMutableArray* f = [NSMutableArray arrayWithCapacity:5];
                [f addObject:zh];
                NSArray* keys = [NSArray arrayWithObjects:@"exact",@"identical",@"further", nil];
                NSArray* objs = [NSArray arrayWithObjects: e, i, f, nil];
                [trie setObject: [NSDictionary dictionaryWithObjects:objs forKeys:keys] forKey:further_def];
            }
            [[trie_obj objectForKey:@"further"] addObject:zh]; 
        }
        // rule 4: if ^x add to identical
        if ([[exact_def substringToIndex:1] isEqualToString:@"x"]){
            [[[trie objectForKey:[exact_def substringFromIndex:1]] objectForKey:@"identical"] addObject:zh];
        }
    }
    NSLog(@"trie configured");
    NSString *err=Nil;
    NSData *trieData = [NSPropertyListSerialization dataFromPropertyList:trie
                                                                 format:NSPropertyListBinaryFormat_v1_0
                                                       errorDescription:&err];
    if (!trieData) NSLog(@"%@",err);
    [trieData writeToFile:[data_path stringByAppendingPathComponent:@"cangjie_trie.plist"] atomically:YES];
    
    NSData *keynameData = [NSPropertyListSerialization dataFromPropertyList:keyname_dict
                                                                  format:NSPropertyListBinaryFormat_v1_0
                                                        errorDescription:&err];
    if (!keynameData) NSLog(@"%@",err);
    [keynameData writeToFile:[data_path stringByAppendingPathComponent:@"cangjie_keyname.plist"] atomically:YES];
    

    [pool drain];
    return 0;
}

