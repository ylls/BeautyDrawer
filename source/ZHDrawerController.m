//
//  ZHDrawerController.m
//  BeautyDrawer
//
//  Created by Mr.Sunday on 15/6/12.
//  Copyright (c) 2015年 novogene. All rights reserved.
//

#import "ZHDrawerController.h"

//获取屏幕size
#define ViewSize [UIScreen mainScreen].bounds.size

//状态栏的height = 20
CGFloat const gestureMinimumTranslation = 20.0 ;

// 滑动方向
typedef NS_ENUM(NSInteger, CameraMoveDirection) {
    kCameraMoveDirectionNone,
    
    kCameraMoveDirectionUp,
    
    kCameraMoveDirectionDown,
    
    kCameraMoveDirectionRight,
    
    kCameraMoveDirectionLeft,
};

@interface ZHDrawerController () <UIGestureRecognizerDelegate>

// 视图
@property (nonatomic, strong) UIViewController *leftControl;
@property (nonatomic, strong) UIViewController *mainControl;
@property (nonatomic, strong) UIViewController *righControl;

@property (nonatomic, assign) CGFloat scalef;
@property (nonatomic, strong) UIImageView *imgBackground;

// 方向
@property (nonatomic, assign) CameraMoveDirection direction;

@end

@implementation ZHDrawerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.view addSubview:mainControl.view];
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - initalization
// 构造方法1
-(instancetype)initWithLeftController:(UIViewController *)leftController
                    andMainController:(UIViewController *)mainController
                   andRightController:(UIViewController *)rightController
                   andBackgroundImage:(UIImage *)image;
{
    if(self){
        //属性赋初始值
        self.speed = 0.5;
        self.hideMainViewScale = 0.8;
        self.backMainViewScale = 1;
        self.centerDeviationX = 0.05;
        self.centerDeviationY = 1;
        
        
        self.leftControl = leftController;
        self.mainControl = mainController;
        self.righControl = rightController;
        
        if (image != nil)
        {
            UIImageView * imgview = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            [imgview setImage:image];
            [self.view addSubview:imgview];
        }
        
        //滑动手势
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
        
        pan.delegate = self;
        
        [self.mainControl.view addGestureRecognizer:pan];
        
        
        //单击手势
        self.sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        //单击一次
        [self.sideslipTapGes setNumberOfTapsRequired:1];
        
        [self.mainControl.view addGestureRecognizer:self.sideslipTapGes];
        
        //隐藏左右控制器视图
        self.leftControl.view.hidden = YES;
        self.righControl.view.hidden = YES;
        
        [self.view addSubview:self.leftControl.view];
        [self.view addSubview:self.righControl.view];
        [self.view addSubview:self.mainControl.view];
        
        //把三个控制器添加到子视图控制器中，不添加的话会出现响应者链条不响应的问题
        if (self.leftControl != nil) [self addChildViewController:self.leftControl];
        if (self.righControl != nil) [self addChildViewController:self.righControl];
        if (self.mainControl != nil) [self addChildViewController:self.mainControl];
    }
    return self;
}

// 构造方法 设置 左右控制器
-(instancetype)initWithLeftController:(UIViewController *)leftController
                    andMainController:(UIViewController *)mainController
                   andRightController:(UIViewController *)rightController {
    
    return [self initWithLeftController:leftController andMainController:mainController andRightController:rightController andBackgroundImage:nil];
}

// 构造方法 设置左控制器
-(instancetype)initWithLeftController:(UIViewController *)leftController andMainView:(UIViewController *)mainController
{
    
    return [self initWithLeftController:leftController andMainController:mainController andRightController:nil andBackgroundImage:nil];
}

// 构造方法 设置右控制器
-(instancetype)initWithRightView:(UIViewController *)rightController andMainView:(UIViewController *)mainController {
    
    return [self initWithLeftController:nil andMainController:mainController andRightController:rightController andBackgroundImage:nil];
}

#pragma mark - UIGestureRecognizerDelegate
// 设置手势滑动 和 tableView 滚动并存 (防止竖直滚动时存在水平滚动导致view晃动)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return NO;
}


#pragma mark - 判断滑动方向
- (void)handleSwipe:(UIPanGestureRecognizer *)gesture
{
    
    CGPoint translation = [gesture translationInView: self.view];
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        self.direction = kCameraMoveDirectionNone;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged && self.direction == kCameraMoveDirectionNone)
    {
        // 获取 方向
        self.direction = [self determineCameraDirectionIfNeeded:translation];
    }
    
    if (self.direction == kCameraMoveDirectionRight && self.leftControl != nil) {
        
        [self handlePan:gesture];
    }
    
    if (self.direction == kCameraMoveDirectionLeft && self.righControl != nil) {
        
        [self handlePan:gesture];
    }
}

- (CameraMoveDirection)determineCameraDirectionIfNeeded:(CGPoint)translation
{
    if (self.direction != kCameraMoveDirectionNone)
        return self.direction;
    
    if (fabs(translation.x) > gestureMinimumTranslation)
    {
        BOOL gestureHorizontal = NO;
        
        if (translation.y == 0.0)
        {
            gestureHorizontal = YES;
        }
        else
        {
            gestureHorizontal = (fabs(translation.x / translation.y) > 5.0 );
        }
        
        if (gestureHorizontal)
        {
            if (translation.x > 0.0 )
            {
                return kCameraMoveDirectionRight;
            }
            else
            {
                return kCameraMoveDirectionLeft;
            }
        }
    }
    else if (fabs(translation.y) > gestureMinimumTranslation)
    {
        BOOL gestureVertical = NO;
        
        if (translation.x == 0.0 )
        {
            gestureVertical = YES;
        }
        else
        {
            gestureVertical = (fabs(translation.y / translation.x) > 5.0 );
        }
        
        if (gestureVertical)
        {
            if (translation.y > 0.0 )
            {
                return kCameraMoveDirectionDown;
            }
            else
            {
                return kCameraMoveDirectionUp;
            }
        }
    }
    return self.direction;
}

#pragma mark - 滑动手势
// 滑动手势
- (void)handlePan:(UIPanGestureRecognizer *)rec{
    
    CGPoint point = [rec translationInView:self.view];
    
    self.scalef = (point.x * self.speed + self.scalef);
    
    rec.view.center = CGPointMake(rec.view.center.x + point.x*self.speed,rec.view.center.y);
    
    //根据视图位置判断是左滑还是右边滑动
    if (rec.view.frame.origin.x > 0)
    {
        //向右滑动
        if (self.hideMainViewScale < 1)
        {
            rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1-self.scalef/1000, 1-self.scalef/1000);
        }
        
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
        
        self.righControl.view.hidden = YES;
        self.leftControl.view.hidden = NO;
        
    }
    else if (rec.view.frame.origin.x < 0)
    {
        //向左滑动
        if (self.hideMainViewScale < 1)
        {
            rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1+self.scalef/1000,1+self.scalef/1000);
        }
        
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
        
        self.righControl.view.hidden = NO;
        self.leftControl.view.hidden = YES;
    }
    
    
    //手势结束后修正位置!
    if (rec.state == UIGestureRecognizerStateEnded)
    {
        if (self.scalef > 140 * self.speed && self.leftControl != nil)
        {
            
            [self showLeftView];
        }
        else if (self.scalef < -140 * self.speed  && self.righControl != nil)
        {
            
            [self showRighView];
        }
        else
        {
            [self showMainView];
            self.scalef = 0;
        }
    }
}

#pragma mark - 单击手势
// 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if (tap.state == UIGestureRecognizerStateEnded)
    {
        //主视图控制器恢复主页面
        [self ShowView:tap.view scaleX:self.backMainViewScale scaleY:self.backMainViewScale centerDeviationX:1.0 centerDeviationY:1.0];
        
        self.scalef = 0;
    }
}

#pragma mark - 修改视图位置
// 恢复位置
-(void)showMainView
{
    [self ShowView:self.mainControl.view scaleX:self.backMainViewScale scaleY:self.backMainViewScale centerDeviationX:1.0 centerDeviationY:1.0];
}

// 显示左视图
-(void)showLeftView
{
    [self ShowView:self.mainControl.view scaleX:self.hideMainViewScale scaleY:self.hideMainViewScale centerDeviationX:(2+self.centerDeviationX) centerDeviationY:self.centerDeviationY];
}

// 显示右视图
-(void)showRighView
{
    [self ShowView:self.mainControl.view scaleX:self.hideMainViewScale scaleY:self.hideMainViewScale centerDeviationX:(-self.centerDeviationX) centerDeviationY:self.centerDeviationY];
}

#pragma mark - view 缩放比例
- (void)ShowView:(UIView *)view scaleX:(CGFloat)Xscale scaleY:(CGFloat)Yscale centerDeviationX:(CGFloat)Xdeviation  centerDeviationY:(CGFloat)Ydeviation
{
    [UIView beginAnimations:nil context:nil];
    
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, Xscale, Yscale);
    
    self.mainControl.view.center = CGPointMake(ViewSize.width*0.5*Xdeviation, (ViewSize.height)*0.5*Ydeviation);
    
    [UIView commitAnimations];
}

#pragma mark - 状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES; //返回NO表示要显示，返回YES将hiden
}

@end
