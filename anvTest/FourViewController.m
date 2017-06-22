//
//  FourViewController.m
//  anvTest
//
//  Created by zhanghangzhen on 2017/6/22.
//  Copyright © 2017年 xbk. All rights reserved.
//

#import "FourViewController.h"
#import "SecondViewController.h"
#import "UIImage+YPAddtion.h"
@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];}
 
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor purpleColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}
@end
