# JYEmptyView
Empty view if no net work or no data for iOS

# Podfile
platform :ios, '7.0'

pod "JYEmptyView"


## Rely
We need to rely on a few tools in the Tools folder inside CommmonTools
需要依赖 几个工具类 工具类 在CommmonTools 文件夹里面

## How to use

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
