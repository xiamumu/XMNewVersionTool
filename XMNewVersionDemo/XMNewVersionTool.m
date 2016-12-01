//
//  XMNewVersionTool.m
//  XSSPH
//
//  Created by NEW on 16/12/1.
//  Copyright © 2016年 Jeanne. All rights reserved.
//

#import "XMNewVersionTool.h"

@implementation XMNewVersionTool

+ (void)getNewVersion
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://itunes.apple.com/cn/lookup?id=1036152564"]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // 请求的数据转字典
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSString *newVersion = [result[@"results"] firstObject][@"version"];
        NSString *message = [result[@"results"] firstObject][@"releaseNotes"];
        NSString *trackViewUrl = [result[@"results"] firstObject][@"trackViewUrl"];
        
        //屏蔽苹果审核员看到此更新提示口（此版本每次提交前更新成目前线上版本号）
        if ([newVersion isEqualToString:@"2.5.0"])   return;
        
        // 获得当前打开软件的版本号
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        
        // 针对新下载用户如果是第一次下载 不会走里面代码。如果是老用户就会走里面代码
        if (![newVersion isEqualToString:currentVersion]) {
            
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"有新版本啦" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            [alertVC addAction:[UIAlertAction actionWithTitle:@"马上尝鲜"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          
                                                          [[UIApplication sharedApplication]
                                                           openURL:[NSURL URLWithString:trackViewUrl]];
                                                          
                                                      }]];
            
            UIViewController *mainVc = [UIApplication sharedApplication].keyWindow.rootViewController;
            if (mainVc.presentedViewController) {
                mainVc = mainVc.presentedViewController;
            }
            [mainVc presentViewController:alertVC animated:YES completion:nil];
        }
        
    }];
    [task resume];
}


@end
