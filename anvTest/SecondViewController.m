//
//  SecondViewController.m
//  anvTest
//
//  Created by zhanghangzhen on 2017/6/22.
//  Copyright © 2017年 xbk. All rights reserved.
//

#import "SecondViewController.h"
#import "UIImage+YPAddtion.h"

#import "ThirdViewController.h"






@interface SecondViewController ()

@end

@implementation SecondViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
 
}

#pragma mark ---生命周期---

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];

    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    ThirdViewController *v = [[ThirdViewController alloc]init];
    v.view.backgroundColor = [UIColor greenColor];
    
    
    [self.navigationController pushViewController:v animated:YES];
    
    
    
}



@end
