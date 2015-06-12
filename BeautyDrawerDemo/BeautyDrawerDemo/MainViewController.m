//
//  MainViewController.m
//  BeautyDrawerDemo
//
//  Created by Mr.Sunday on 15/6/13.
//  Copyright (c) 2015年 novogene. All rights reserved.
//

#import "MainViewController.h"
#import <BeautyDrawer/ZHDrawerController.h>

@interface MainViewController ()

@property (nonatomic, strong) ZHDrawerController *drawerController;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *buttonLeft = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    [buttonLeft setImage:[UIImage imageNamed:@"setting-icon-1-1-1"] forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(showLeftView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonRight = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    
    
    [self.view addSubview:buttonLeft];
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view.
}

- (void)showLeftView
{
    [self.drawerController showLeftView];
}

- (void)showRightView
{
    [self.drawerController showRighView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
