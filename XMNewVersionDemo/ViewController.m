//
//  ViewController.m
//  XMNewVersionDemo
//
//  Created by NEW on 16/12/1.
//  Copyright © 2016年 XM. All rights reserved.
//

#import "ViewController.h"

// 版本更新头文件
#import "XMNewVersionTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [XMNewVersionTool getNewVersion];
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
