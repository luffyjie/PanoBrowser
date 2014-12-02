//
//  PanoBrowserView.m
//  Xinhu
//
//  Created by Nero on 14-9-9.
//  Copyright (c) 2014年 www.baitu.com 杭州百图科技有限公司. All rights reserved.
//

#import "PanoBrowserView.h"

@implementation PanoBrowserView
@synthesize subPathArray = _subPathArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _requestCount = 0;
        self.backgroundColor = [UIColor clearColor];
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _webView.backgroundColor = [UIColor clearColor];
        _webView.delegate = self;
        [self addSubview:_webView];
        [self initButtons];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame htmlFilePath:(NSString *)filePath
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        if (filePath) {
            _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            _webView.backgroundColor = [UIColor clearColor];
            NSURL *url = [NSURL fileURLWithPath:filePath];
            if (url) {
                _mainPanoName = [filePath lastPathComponent];
                [_webView loadRequest:[NSURLRequest requestWithURL:url]];
                [self addSubview:_webView];
            }
        }
        [self initButtons];
        
    }
    return self;
}

- (void)initButtons
{
    _btnPrevious = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnPrevious.frame = CGRectMake(kBtnPreviousToLeft, kBtnToTop, kBtnWidth, kBtnHeight);
    [_btnPrevious setImage:[UIImage imageNamed:PanoSrcName(@"btn_page_previous")] forState:UIControlStateNormal];
    [_btnPrevious addTarget:self action:@selector(showPreviousPage) forControlEvents:UIControlEventTouchUpInside];
    
    _btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnNext.frame = CGRectMake(kBtnNextToLeft, kBtnToTop, kBtnWidth, kBtnHeight);
    [_btnNext setImage:[UIImage imageNamed:PanoSrcName(@"btn_page_next")] forState:UIControlStateNormal];
    [_btnNext addTarget:self action:@selector(showNextPage) forControlEvents:UIControlEventTouchUpInside];
    
    _btnExitPano = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnExitPano.frame = CGRectMake(kBtnExitToLeft, kBtnExitToTop, kBtnExitWidth, kBtnHeight);
    [_btnExitPano setImage:[UIImage imageNamed:PanoSrcName(@"btn_exit")] forState:UIControlStateNormal];
    [_btnExitPano addTarget:self action:@selector(exitPano) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_btnPrevious];
    [self addSubview:_btnNext];
    [self addSubview:_btnExitPano];

}


- (void)setFilePath:(NSString *)filePath
{
    if (filePath) {
        NSURL *url = [NSURL fileURLWithPath:filePath];
        if (url) {
            _mainPanoName = [filePath lastPathComponent];
            _filePath = filePath;
            [_webView loadRequest:[NSURLRequest requestWithURL:url]];
        }
    }
}

- (void)showPreviousPage
{
    if ([self.delegate respondsToSelector:@selector(showPreviousPage:)]) {
        [self.delegate showPreviousPage:self];
    }
}

- (void)showNextPage
{
    if ([self.delegate respondsToSelector:@selector(showNextPage:)]) {
        [self.delegate showNextPage:self];
    }
}

- (void)exitPano
{
    if ([self.delegate respondsToSelector:@selector(exitPanoBrowser:)]) {
        [self.delegate exitPanoBrowser:self];
    }
}

- (void)disableExitButton
{
    if (_btnExitPano) {
        _btnExitPano.hidden = YES;
        [_btnExitPano removeFromSuperview];
    }
}

- (void)clear
{
    [_webView removeFromSuperview];
    _webView = nil;
}

- (void)hiddenNavButtons
{
    _btnNext.hidden = YES;
    _btnPrevious.hidden = YES;
    [_btnNext setEnabled:NO];
    [_btnPrevious setEnabled:NO];
}

- (void)showNavButtons
{
    _btnNext.hidden = NO;
    _btnPrevious.hidden = NO;
    [_btnNext setEnabled:YES];
    [_btnPrevious setEnabled:YES];
}

- (NSString *)lastPathComponent
{
    return _currentPath;
}


#pragma mark - web view delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSLog(@"path : %@, absolute string : %@", request.URL.path, request.URL.absoluteString);
    BOOL isMainPano = YES;
    NSString *lastPathComponent = [request.URL.path lastPathComponent];
    _currentPath = lastPathComponent;
    if (_subPathArray) {
        for (NSString *subPath in _subPathArray) {
            if ([lastPathComponent isEqual:subPath]) {
//                NSLog(@"in sub path : %@", subPath);
                isMainPano = NO;
                [self hiddenNavButtons];
                if ([self.delegate respondsToSelector:@selector(showSubPanoInPanoBrowser:)]) {
                    [self.delegate showSubPanoInPanoBrowser:self];
                }
            }
        }
    }
//    NSLog(@"%@", lastPathComponent);
//    NSLog(@"%@", _mainPanoName);
    if (_requestCount > 0 && isMainPano && [lastPathComponent isEqual:_mainPanoName]) {
//        NSLog(@"This is main pano : %@", lastPathComponent);
        [self showNavButtons];
        if ([self.delegate respondsToSelector:@selector(showMainPanoInPanoBrowser:)]) {
            [self.delegate showMainPanoInPanoBrowser:self];
        }
    }
    _requestCount++;
    return YES;
}

@end
