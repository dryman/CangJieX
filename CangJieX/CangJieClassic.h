//
//  CangJieClassic.h
//  CangJieX
//
//  Created by Felix Ren-Chyan Chern on 12/1/4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <InputMethodKit/InputMethodKit.h>

@interface CangJieClassic : IMKInputController {
    NSMutableString *_originalBuffer;
    NSMutableString *_composedBuffer;
}


@end
