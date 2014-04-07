//
//  MainViewScrollManager.h
//  Emoticons
//
//  Created by SSC on 2014/04/07.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MainViewScrollManagerDelegate <NSObject>
- (void)scrollView:(UIScrollView *)scrollView didPageChange:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewEndScroll:(UIScrollView *)scrollView;
@end

@interface MainViewScrollManager : NSObject <UIScrollViewDelegate>
{
    int _currentPage;
}

@property (nonatomic, weak) id<MainViewScrollManagerDelegate> delegate;

+ (MainViewScrollManager*)instance;

@end
