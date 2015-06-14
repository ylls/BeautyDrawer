//
//  LeftViewController.m
//  BeautyDrawerDemo
//
//  Created by Mr.Sunday on 15/6/13.
//  Copyright (c) 2015年 novogene. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    img.image = [UIImage imageNamed:@"mv_left.png"];
    //img.image = [UIImage imageNamed:@"left.jpg"];
    
    [self.view addSubview:img];
    
    
    //self.view.backgroundColor = [UIColor purpleColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
