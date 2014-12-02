//
//  PanoBrowserView.h
//  Xinhu
//
//  Created by Nero on 14-9-9.
//  Copyright (c) 2014年 www.baitu.com 杭州百图科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PanoConsts.h"

@class PanoBrowserView;

@protocol PanoBrowserViewDelegate <NSObject>

@optional
- (void)showPreviousPage:(PanoBrowserView *)panoBrowserView;
- (void)showNextPage:(PanoBrowserView *)panoBrowserView;
- (void)exitPanoBrowser:(PanoBrowserView *)panoBrowserView;
- (void)showSubPanoInPanoBrowser:(PanoBrowserView *)panoBrowserView;
- (void)showMainPanoInPanoBrowser:(PanoBrowserView *)panoBrowserView;
@end

@interface PanoBrowserView : UIView<UIWebViewDelegate>
{
@private
    UIWebView *_webView;
    UIButton *_btnPrevious;
    UIButton *_btnNext;
    UIButton *_btnExitPano;
    NSArray *_subPathArray;
    NSString *_mainPanoName;
    int _requestCount;
    NSString *_currentPath;
}

- (id)initWithFrame:(CGRect)frame htmlFilePath:(NSString *)filePath;

@property (nonatomic,strong) NSArray *subPathArray;
@property (nonatomic,strong) NSString *filePath;
@property (nonatomic,weak) id<PanoBrowserViewDelegate> delegate;

- (void)disableExitButton;
- (void)clear;
- (void)showNavButtons;
- (void)hiddenNavButtons;
- (NSString *)lastPathComponent;

@end
