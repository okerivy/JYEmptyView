//
//  ViewController.m
//  JYEmptyViewDemo
//
//  Created by  李辉 on 15/7/8.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "ViewController.h"
#import "JYEmptyView.h"
#import "UIColor+Hex.h"
#import "UIView+Extension.h"

@interface ViewController ()
/** 转圈 */
@property (nonatomic, strong) UIActivityIndicatorView *actView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 模拟网络请求
    [self getDataFromSer];
    
    
}

/** 模拟网络请求 */
- (void)getDataFromSer
{
    self.actView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.centerX, self.view.centerY, 0, 0)];
    [self.view addSubview:self.actView];
    self.actView.hidesWhenStopped = YES;
    [self.actView startAnimating];
    self.actView.color = [UIColor redColor];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 请求失败
        [self setupEmptyView];
        
    });
}

// 无网络的数据图片
- (void)setupEmptyView
{
    
    [self.actView stopAnimating];
    
    // 添加占位图片
    __weak __typeof(self)weakSelf = self;
    [JYEmptyView emptyViewWithSuperView:self.view imageName:@"nonetwork" labTitles:[NSMutableArray arrayWithObjects:@"网络连接失败", nil] buttonTitle:@"点击重试" myBlcok:^(UIButton *btn) {
        
        NSLog(@"%s", __func__);

        // 按钮的点击事件
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [JYEmptyView hideJYEmptyView:strongSelf.view];
        
        // 模拟网络请求
        [strongSelf getDataFromSer];
        
    }];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
    
}

@end
