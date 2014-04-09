//
//  CurrentSettings.h
//  Emoticons
//
//  Created by SSC on 2014/04/08.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentSettings : NSObject

+ (CGFloat)textSizeForEditor;
+ (UIFont*)fontForEditor;
+ (BOOL)showCursorWhenDragging;

@end
