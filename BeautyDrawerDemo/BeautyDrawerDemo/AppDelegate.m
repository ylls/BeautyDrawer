//
//  AppDelegate.m
//  BeautyDrawerDemo
//
//  Created by Mr.Sunday on 15/6/12.
//  Copyright (c) 2015年 novogene. All rights reserved.
//

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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
