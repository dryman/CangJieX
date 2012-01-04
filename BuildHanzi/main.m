//
//  main.m
//  BuildHanzi
//
//  Created by Felix Ren-Chyan Chern on 12/1/1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDFileReader.h"
#define MACRO_VALUE_TO_STRING_( m ) #m
#define MACRO_VALUE_TO_STRING( m ) MACRO_VALUE_TO_STRING_( m )


int main (int argc, const char * argv[])
{

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    // insert code here...
    NSLog(@"Hello, World!");
    NSLog(@"start init");
    NSMutableArray *cj5_def = [NSMutableArray arrayWithCapacity:70000];
    NSMutableArray *zhy_def = [NSMutableArray arrayWithCapacity:70000];
    NSMutableArray *cj5_char = [NSMutableArray arrayWithCapacity:70000];
    NSMutableArray *zhy_char = [NSMutableArray arrayWithCapacity:70000];
    // NSUInteger retainCount;
    
    NSString *current_path = @""
        MACRO_VALUE_TO_STRING(SRC_ROOT)
        "/BuildHanzi";
    NSLog(@"path is %@",current_path);
    
    // Read cangjie.cin
    NSString *cj5path = [current_path stringByAppendingPathComponent:@"cangjie.cin"];
    DDFileReader *reader = [[DDFileReader alloc] initWithFilePath:cj5path];
    NSString *line;
    while ((line = [reader readChompedLine])){
        if ([[line substringToIndex:1] isEqualToString:@"%"] ||
            [[line substringToIndex:1] isEqualToString:@"#"]){ // skip lines with prefix % and #
            continue;
        }
        NSArray *pair = [line componentsSeparatedByString:@" "];
        [cj5_def addObject:[pair objectAtIndex:0]]; // retain count 2
        [cj5_char addObject:[pair objectAtIndex:1]]; // retain count 2
        
    }
    [reader release];
    // Read zhuyin.cin
    NSString* zhypath = [current_path stringByAppendingPathComponent:@"zhuyin.cin"];
    reader = [[DDFileReader alloc] initWithFilePath:zhypath];
    NSString* l;
    while ((l = [reader readLine])){
        if ([[l substringToIndex:1] isEqualToString:@"%"] ||
            [[l substringToIndex:1] isEqualToString:@"#"]){continue;}
        
        line =[l substringToIndex: [l length]-2];
        NSArray *pair = [line componentsSeparatedByString:@" "];
        [zhy_def addObject:[pair objectAtIndex:0]];
        [zhy_char addObject:[pair objectAtIndex:1]]; // retain count is UINT_MAX
    }
    [reader release];
    
    
    NSMutableArray *attrs = [NSMutableArray arrayWithCapacity:70000];
    
    for (NSString* zh in cj5_char){
        NSMutableArray* c = [NSMutableArray arrayWithCapacity:3];
        NSMutableArray* z = [NSMutableArray arrayWithCapacity:3];
        
        NSArray *keys = [NSArray arrayWithObjects:@"cangjie",@"zhuyin", nil];
        [attrs addObject:
         [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: c,z, nil]
                                     forKeys:keys]];
    }
    NSDictionary* hanziDict = [NSDictionary dictionaryWithObjects:attrs forKeys:cj5_char];
    NSLog(@"hanzi alloc finished");
    int num = (int)[cj5_char count];
    for (int i=0; i<num; ++i){
        [[[hanziDict objectForKey:[cj5_char objectAtIndex:i]] 
          objectForKey:@"cangjie"] 
         addObject:[cj5_def objectAtIndex:i]];
    }
    NSLog(@"cj5 init finished");
    num = (int)[zhy_char count];
    for (int i=0; i<num; ++i){
        [[[hanziDict objectForKey:[zhy_char objectAtIndex:i]] 
          objectForKey:@"zhuyin"] 
         addObject:[zhy_def objectAtIndex:i]];
    }
    NSLog(@"hanzi init finished");
    NSString *err = Nil;
    NSData *dataRep = [NSPropertyListSerialization dataFromPropertyList:hanziDict 
                                                                 format:NSPropertyListBinaryFormat_v1_0
                                                       errorDescription:&err];
    if (!dataRep)
        NSLog(@"%@",err);
    [dataRep writeToFile:[current_path stringByAppendingPathComponent:@"hanzi.plist"] atomically:NO];
    
    [pool drain];
    return 0;
}

