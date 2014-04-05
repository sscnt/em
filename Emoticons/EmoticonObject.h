//
//  EmoticonObject.h
//  Emoticons
//
//  Created by SSC on 2014/04/05.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmoticonObject : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, strong) NSString* emoticon;
@property (nonatomic, assign) int categoryId;
@property (nonatomic, assign) int lastUseTime;
@property (nonatomic, assign) BOOL addedByUser;

@end
