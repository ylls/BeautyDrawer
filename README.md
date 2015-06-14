# BeautyDrawer
BeautyDrawer 是一款简单易用的抽屉效果实现框架，集成的属性可以对view 滑动缩放进行控制。

#Main features
* 三个视图，主视图可以左右滑动，实现抽屉效果
* 应用框架接口的内置参数属性可以对view的滑动速度，偏移度，和缩放比例进行设置
* 简单易用

#Demonstration
![image](https://github.com/HuanDay/BeautyDrawer/blob/master/BeautyDrawerDemo/beautyDrawer2.gif) ![image](https://github.com/HuanDay/BeautyDrawer/blob/master/BeautyDrawerDemo/beautyDrawer1.gif) 

#Requirements
* iOS 6.0+ 
* Xcode 6.1.1

#Installation
手动导入:
  * 将`BeautyDrawer/Resource`文件夹中的所有文件拽入项目中
  * 导入主头文件`<BeautyDrawer/ZHDrawerController.h>`

#API
##Properties
```
/*
 *主视图隐藏后显示比例(0~1) 是对主视图大小缩放的属性： 0.8
 */
@property (nonatomic, assign) CGFloat hideMainViewScale;

/**
 *主视图点击或拖拉恢复后比例 (0~1) 默认:1
 */
@property (nonatomic, assign) CGFloat backMainViewScale;

/*
 *主视图拖拽后centerX偏移比例，默认:0.05
 */
@property (nonatomic, assign) CGFloat centerDeviationX;

/*
 *主视图centerY偏移比例，默认:1
 */
@property (nonatomic, assign) CGFloat centerDeviationY;

/*
 *滑动速度系数-建议在0.5-1之间。默认为0.5
 */
@property (assign,nonatomic) CGFloat speed;

/*
 *是否允许点击视图恢复视图位置。默认为yes
 */
@property (strong) UITapGestureRecognizer *sideslipTapGes;

```

##Method
不同的构造方法可以实现不同视图的格局
```
/*
 *构造方法(左控制器 & 主控制器 &右控制器 & 背景图片)
 */
- (instancetype)initWithLeftController:(UIViewController *)leftController
                    andMainController:(UIViewController *)mainController
                   andRightController:(UIViewController *)rightController
                   andBackgroundImage:(UIImage *)image;

/*
 *构造方法(左控制器 & 主控制器 & 又控制器)
 */
- (instancetype)initWithLeftController:(UIViewController *)leftController
                    andMainController:(UIViewController *)mainController
                   andRightController:(UIViewController *)rightController;

/*
 *构造方法(左控制器 & 主控制器)
 */
- (instancetype)initWithLeftController:(UIViewController *)leftController andMainView:(UIViewController *)mainController;

/*
 *构造方法(右控制器 & 主控制器)
 */
- (instancetype)initWithRightView:(UIViewController *)rightController andMainView:(UIViewController *)mainController;
```

#Usage
##appdelegate 设置`(required)`
在appdelegate.m 文件中对视图初始化
```
#import "AppDelegate.h"
#import "LeftViewController.h"
#import "MainViewController.h"
#import "RightViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 1. 创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 2. 创建控制器
    MainViewController *main = [[MainViewController alloc] init];
    LeftViewController *left = [[LeftViewController alloc] init];
    RightViewController *right = [[RightViewController alloc] init];
    
    // 3. 创建跟控制器
   self.controller = [[ZHDrawerController alloc] initWithLeftController:left andMainController:main andRightController:right];
    self.controller.hideMainViewScale = 0.8;
    self.controller.backMainViewScale = 1.0;
    self.controller.centerDeviationX = 0.2;
    
    // 4. 设置跟控制器
    self.window.rootViewController = self.controller;
    
    // 5. 显示 window
    [self.window makeKeyAndVisible];
    
    return YES;
}

```

##对视图添加子view显示
在leftView，rightView, mainView中自定义view
```
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //不缩放 hideMainViewScale = 1.0
    [self addImage];
    
    //缩放 hideMainViewScale = 0.8
    //[self loadAddView];
}

- (void)addImage
{
    UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    img.image = [UIImage imageNamed:@"main.jpg"];
    
    [self.view addSubview:img];

}
```

#Update
* v1.2 开放了缩放比例，偏移位置，滑动速度属性API
* v1.3 解决mainView为tableView，上下滑动时出现左右偏移的问题

#Project Introduction
http://blog.csdn.net/liulanghk/article/details/46415701
致谢wangxiaoit童鞋

#License
BeautyDrawer is released under the MIT license. See LICENSE for details.
