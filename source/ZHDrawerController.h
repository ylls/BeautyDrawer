//
//  ZHDrawerController.h
//  BeautyDrawer
//
//  Created by Mr.Sunday on 15/6/12.
//  Copyright (c) 2015年 novogene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHDrawerController : UIViewController

/// 主视图隐藏后显示比例(0~1) 是对主视图大小缩放的属性： 0.8
@property (nonatomic, assign) CGFloat hideMainViewScale;

/// 主视图被拉恢复后比例 (0~1) 默认:1
@property (nonatomic, assign) CGFloat backMainViewScale;


//主视图centerX偏移，默认:0.05
@property (nonatomic, assign) CGFloat centerDeviationX;

//主视图centerY偏移，默认:1
@property (nonatomic, assign) CGFloat centerDeviationY;

/// 滑动速度系数-建议在0.5-1之间。默认为0.5
@property (assign,nonatomic) CGFloat speed;

/// 是否允许点击视图恢复视图位置。默认为yes
@property (strong) UITapGestureRecognizer *sideslipTapGes;


#pragma mark - initialization
/// 构造方法(左控制器 & 主控制器 &右控制器 & 背景图片)
-(instancetype)initWithLeftController:(UIViewController *)leftController
                    andMainController:(UIViewController *)mainController
                   andRightController:(UIViewController *)rightController
                   andBackgroundImage:(UIImage *)image;

/// 构造方法(左控制器 & 主控制器 & 又控制器)
-(instancetype)initWithLeftController:(UIViewController *)leftController
                    andMainController:(UIViewController *)mainController
                   andRightController:(UIViewController *)rightController;

/// 构造方法(左控制器 & 主控制器)
-(instancetype)initWithLeftController:(UIViewController *)leftController andMainView:(UIViewController *)mainController;

/// 构造方法(右控制器 & 主控制器)
-(instancetype)initWithRightView:(UIViewController *)rightController andMainView:(UIViewController *)mainController;

#pragma mark -show view
/// 恢复位置
-(void)showMainView;

/// 显示左视图
-(void)showLeftView;

/// 显示右视图
-(void)showRighView;


@end
