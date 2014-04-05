//
//  CategoryObject.h
//  Emoticons
//
//  Created by SSC on 2014/04/05.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryObject : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) int parent_id;

@end
