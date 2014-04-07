//
//  ViewController.m
//  Emoticons
//
//  Created by SSC on 2014/04/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)loadView
{
    self.view = [[UIBackgroundView alloc] initWithFrame:[UIScreen screenRect]];
}

- (void)viewDidLoad
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [super viewDidLoad];
    
    _currentPage = MainViewPageIdChooser;
    [MainViewScrollManager instance].delegate = self;
    
    //// Scroll View
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen screenRect]];
    _scrollView.delegate = [MainViewScrollManager instance];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake([UIScreen width] * 3.0f, _scrollView.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.scrollEnabled = NO;
    [self.view addSubview:_scrollView];
    
    
    //// Chooser
    _chooserView = [[UIEmoticonsChooserView alloc] initWithFrame:CGRectMake(10.0f, 30.0f, [UIScreen width] - 20.0f, [UIScreen height])];
    _chooserView.visibleSize = CGSizeMake([UIScreen width] - 20.0f, [UIScreen height] - 30.0f);
    if([UIDevice isIOS6]){
        [_chooserView setY:10.0f];
        _chooserView.visibleSize = CGSizeMake([UIScreen width] - 20.0f, [UIScreen height] - 30.0f);
    }
    _chooserView.delegate = self;
    [_scrollView addSubview:_chooserView];
}

- (void)viewDidAppear:(BOOL)animated
{

}

#pragma mark delegate

- (void)didSelectEmoticon:(int)emoticon_id
{
    LOG(@"Emoticon %d selected.", emoticon_id);
    [self presentToEditorView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _chooserView.shadow = NO;
    CGPoint p = scrollView.contentOffset;
    if(p.x < scrollView.frame.size.width * 2.0){
        CGFloat ratio = p.x / scrollView.frame.size.width;
        
        CGFloat angle = -15.0f * M_PI / 180.0f * ratio;
        CGFloat x = _chooserView.frame.size.height * 1.50f * sinf(angle) * ratio;
        CGFloat y = _chooserView.frame.size.height * 1.50f * cosf(angle);
        y = _chooserView.frame.size.height * 1.50f - y;
        y *= ratio;
        CGFloat scale = 1.0;
        
        CGAffineTransform concat = CGAffineTransformConcat(CGAffineTransformMakeRotation(angle), CGAffineTransformMakeScale(scale, scale));
        concat = CGAffineTransformConcat(concat, CGAffineTransformMakeTranslation(x, y));
        _chooserView.transform = concat;
    }
}

- (void)scrollViewEndScroll:(UIScrollView *)scrollView
{
    _chooserView.shadow = YES;
}

- (void)scrollView:(UIScrollView *)scrollView didPageChange:(int)page
{
    
}


#pragma mark presenting

- (void)presentToSettingsView
{
    
}

- (void)presentToEditorView
{
    _scrollView.scrollEnabled = YES;
    [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0.0f, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [DataProvider cleanCaches];
}

- (void)dealloc
{
    _scrollView.delegate = nil;
    _chooserView.delegate = nil;
    [MainViewScrollManager instance].delegate = nil;
}

@end
