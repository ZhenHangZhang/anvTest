//
//  ViewController.m
//  anvTest
//
//  Created by zhanghangzhen on 2017/6/22.
//  Copyright © 2017年 xbk. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "ZHZBaseViewController.h"
#import "UIImage+YPAddtion.h"


@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
}
- (IBAction)jump:(id)sender {
    SecondViewController *v = [[SecondViewController alloc]init];
    v.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:v animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];

}

@end
