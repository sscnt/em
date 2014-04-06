//
//  EmoticonsTableManager.m
//  Emoticons
//
//  Created by SSC on 2014/04/06.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "EmoticonsTableManager.h"

@implementation EmoticonsTableManager

#pragma mark table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* emoticons = [DataProvider emoticonObjectsByCategoryId:self.categoryId];
    self.numberOfRows = (int)[emoticons count];
    return self.numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEmoticonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UIEmoticonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSArray* emoticons = [DataProvider emoticonObjectsByCategoryId:self.categoryId];
    EmoticonObject* emo = [emoticons objectAtIndex:indexPath.row];
    if(emo){
        cell.textLabel.text = emo.emoticon;
    }
    return cell;
}

#pragma mark table events

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* emoticons = [DataProvider emoticonObjectsByCategoryId:self.categoryId];
    EmoticonObject* emo = [emoticons objectAtIndex:indexPath.row];
    if(emo){
        [self.delegate tableView:tableView didSelectEmoticon:emo.id];
        return;
    }
    [self.delegate tableView:tableView didSelectEmoticon:0];
}

@end
