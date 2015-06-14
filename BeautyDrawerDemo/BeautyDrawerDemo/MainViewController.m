//
//  MainViewController.m
//  BeautyDrawerDemo
//
//  Created by Mr.Sunday on 15/6/13.
//  Copyright (c) 2015年 novogene. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import <BeautyDrawer/ZHDrawerController.h>

#define ViewSize [UIScreen mainScreen].bounds.size

@interface MainViewController ()

@property (nonatomic, strong) AppDelegate *delegate;

@end
@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //不缩放 hideMainViewScale = 1.0
    //[self addImage];
    
    //缩放 hideMainViewScale = 0.8
    [self loadAddView];
}

- (void)addImage
{
    UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    img.image = [UIImage imageNamed:@"main.jpg"];
    
    [self.view addSubview:img];

}

- (void)loadAddView
{
    UIButton *buttonLeft = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
    
    buttonLeft.backgroundColor = [UIColor grayColor];
    [buttonLeft setTitle:@"左视图" forState:UIControlStateNormal];
    buttonLeft.tintColor = [UIColor whiteColor];
    
    
    [buttonLeft addTarget:self action:@selector(LeftView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonRight = [[UIButton alloc] initWithFrame:CGRectMake(ViewSize.width-80, 10, 70, 30)];
    buttonRight.backgroundColor = [UIColor grayColor];
    [buttonRight setTitle:@"右视图" forState:UIControlStateNormal];
    buttonLeft.tintColor = [UIColor whiteColor];
    
    
    [buttonLeft addTarget:self action:@selector(RightView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buttonLeft];
    [self.view addSubview:buttonRight];
    
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    img.image = [UIImage imageNamed:@"mv_main.jpg"];
    
    [self.view addSubview:img];
}

- (void)LeftView
{
    [self.delegate.controller showLeftView];
}

- (void)RightView
{
    [self.delegate.controller showRighView];
}


@end
