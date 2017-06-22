//
//  ThirdViewController.m
//  anvTest
//
//  Created by zhanghangzhen on 2017/6/22.
//  Copyright © 2017年 xbk. All rights reserved.
//

#import "ThirdViewController.h"
#import "UIImage+YPAddtion.h"
#import "FourViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    FourViewController *v = [[FourViewController alloc]init];
    v.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.navigationController pushViewController:v animated:YES];
    
    
    
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
