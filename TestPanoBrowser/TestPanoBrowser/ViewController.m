//
//  ViewController.m
//  TestPanoBrowser
//
//  Created by lujie on 14/12/1.
//  Copyright (c) 2014年 www.baitutech.com 杭州百图科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "PanoBrowserView.h"

@interface ViewController () <PanoBrowserViewDelegate>

@end

@implementation ViewController

{
    PanoBrowserView *_panoBrowserView;  // 全景浏览器
    NSArray *_panoNameArray;
    NSArray *_panoThumbArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _panoNameArray = [[NSArray alloc] initWithObjects:@"images/Panoramas/lsxy/lszx", nil];
    _panoThumbArray = [[NSArray alloc] initWithObjects:@"images/PanoThumbnails/lsxy/lszx", nil];
    [self showPanoBrowserWithIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showPanoBrowserWithIndex:(int)index
{
        _panoBrowserView = [[PanoBrowserView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) htmlFilePath:[[NSBundle mainBundle] pathForResource:[_panoNameArray objectAtIndex:index] ofType:HTML]];
        _panoBrowserView.delegate = self;
//        [_panoBrowserView hiddenNavButtons];
        _panoBrowserView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        [self.view addSubview:_panoBrowserView];
        [UIView animateWithDuration:0.35 animations:^{
            _panoBrowserView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {

        }];
}

@end
