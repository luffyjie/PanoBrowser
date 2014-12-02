//
//  Consts.h
//  Xinhu
//
//  Created by Nero on 14-8-28.
//  Copyright (c) 2014年 www.baitu.com 杭州百图科技有限公司. All rights reserved.
//
/*
 把html全景展示封装成组建
 使用到全景的地方，可以引入该组件即可
 具体参数可以自行修改和设置
 coder: 2014-12-01 lujie
 */

// 屏幕宽度和高度
#define PanoSCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define PanoSCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

// 全景元素的高度和宽度预定义
#define kBtnWidth 74.0f
#define kBtnHeight 74.0f
#define kBtnToTop self.frame.size.height / 2.0 - kBtnHeight / 2.0
#define kBtnPreviousToLeft 20.0f
#define kBtnNextToLeft self.frame.size.width - kBtnPreviousToLeft - kBtnWidth
#define kBtnExitWidth 40.0f
#define kBtnExitHeight 40.0f
#define kBtnExitToLeft self.frame.size.width - 10.0f - kBtnExitWidth
#define kBtnExitToTop 10.0f

// bundle资源
#define PanoSrcName(file) [@"PanoBrowser.bundle" stringByAppendingPathComponent:file]

// 文件后缀
#define PNG @"png"
#define JPG @"jpg"
#define HTML @"html"


