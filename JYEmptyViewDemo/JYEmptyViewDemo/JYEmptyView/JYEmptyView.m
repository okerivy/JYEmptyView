//
//  JYEmptyView.m
//  mingshi
//
//  Created by  李辉 on 15/2/4.
//  Copyright (c) 2015年 绩优堂. All rights reserved.
//

#import "JYEmptyView.h"
#import "UIColor+Hex.h"
#import "UIView+Extension.h"
#import "NSString+OYExtension.h"



#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define JYUnvFont_17 [UIFont systemFontOfSize:17]
#define JYUnvFontBold_17 [UIFont boldSystemFontOfSize:17]

#define JYEmptyViewLabelTitleFont JYUnvFont_17
#define JYEmptyViewButtonTitleFont JYUnvFontBold_17

// 常用颜色 16位色
#define JYUnvColor_Hex_000000 [UIColor colorWithHexString:@"#000000"] // 灰色1
#define JYUnvColor_Hex_333333 [UIColor colorWithHexString:@"#333333"] // 灰色1
#define JYUnvColor_Hex_666666 [UIColor colorWithHexString:@"#666666"] // 灰色1
#define JYUnvColor_Hex_999999 [UIColor colorWithHexString:@"#999999"] // 灰色2
#define JYUnvColor_Hex_dddddd [UIColor colorWithHexString:@"#dddddd"] // 灰色1
#define JYUnvColor_Hex_ffffff [UIColor colorWithHexString:@"#ffffff"] // 白色
#define JYUnvColor_Hex_f1f0eb [UIColor colorWithHexString:@"#f1f0eb"] // 背景乳白色
#define JYUnvColor_Hex_00b459 [UIColor colorWithHexString:@"#00b459"] // 绿色
#define JYUnvColor_Hex_ff5951 [UIColor colorWithHexString:@"#ff5951"] // 红色





@interface JYEmptyView ()

/** label 字符串字体数组 */
@property (nonatomic, strong)  NSArray *labelTitleArr;
/** button 文字 */
@property (nonatomic, strong)   NSString *btnTitle;
/** 回调方法 */
@property(nonatomic,copy)TouchButton myBlock;
/** imageName */
@property (nonatomic, copy) NSString *imageName;



/** 占位图 */
@property (nonatomic, weak)  UIImageView *imgView;
/** label */
@property (nonatomic, weak)  UILabel *upLabel;
@property (nonatomic, weak)  UILabel *downLabel;
/** button */
@property (nonatomic, weak) UIButton *reBtn;


@end

@implementation JYEmptyView



#pragma mark- 懒加载

/** 占位图 */
- (UIImageView *)imgView
{
    if (!_imgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        if (self.imageName) { // 如果图片存在.
            imgView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:self.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
            [imgView.layer renderInContext:UIGraphicsGetCurrentContext()];
        }
        [self addSubview:imgView];
        self.imgView = imgView;
    }
    return _imgView;
}

/** uplabel */
- (UILabel *)upLabel
{
    if (!_upLabel) {
        UILabel *upLabel = [[UILabel alloc] init];
        self.upLabel = upLabel;
        [self addSubview:upLabel];
        self.upLabel.font = JYEmptyViewLabelTitleFont;
        self.upLabel.textColor = JYUnvColor_Hex_999999;//JYUnvColor_Var(154, 154, 154); // 灰色
    }
    return _upLabel;
}

/** downlabel */
- (UILabel *)downLabel
{
    if (!_downLabel) {
        UILabel *downLabel = [[UILabel alloc] init];
        self.downLabel = downLabel;
        [self addSubview:downLabel];
        self.downLabel.font = JYEmptyViewLabelTitleFont;
        self.downLabel.textColor = JYUnvColor_Hex_999999;//JYUnvColor_Var(154, 154, 154); // 灰色
    }
    return _downLabel;
}

/** reBtn */
- (UIButton *)reBtn
{
    if (!_reBtn) {
        UIButton *reBtn = [[UIButton alloc] init];
        [self addSubview:reBtn];
        self.reBtn = reBtn;
        self.reBtn.titleLabel.font = JYEmptyViewButtonTitleFont;
        [self.reBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.reBtn setImage:[UIImage imageNamed:@"nonetwork_refresh"] forState:UIControlStateNormal];
        [self.reBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [self.reBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.reBtn setBackgroundImage:[UIImage imageNamed:@"nonetwork_renconnent"] forState:UIControlStateNormal];
        [self.reBtn addTarget:self action:@selector(reBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reBtn;
}



#pragma mark- 系统方法



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupViewF];
}



#pragma mark- 初始化方法

+ (void)hideJYEmptyView:(UIView *)superView
{
    if (superView == nil) superView = [UIApplication sharedApplication].keyWindow;
    
    NSMutableArray *emptyViewS = [NSMutableArray array];
    NSArray *subviews = superView.subviews;
    Class emptyClass = [JYEmptyView class];
    for (UIView *view in subviews) {
        if ([view isKindOfClass:emptyClass]) {
            [emptyViewS addObject:view];
        }
    }
    for (UIView *view in emptyViewS) {
        [view removeFromSuperview];
    }
}


+ (instancetype)emptyViewWithSuperView:(UIView *)superView
                             imageName:(NSString *)imageName
                             labTitles:(NSArray *)labTitles
                           buttonTitle:(NSString *)buttonTitle
                               myBlcok:(TouchButton)myBlcok
{
 
    [self hideJYEmptyView:superView];
    return [[self alloc] initWithSuperView:(UIView *)superView
                                 imageName:(NSString *)imageName
                                 labTitles:(NSArray *)labTitles
                               buttonTitle:(NSString *)buttonTitle
                                   myBlcok:(TouchButton)myBlcok];
    
    
}


- (instancetype)initWithSuperView:(UIView *)superView
                        imageName:(NSString *)imageName
                        labTitles:(NSArray *)labTitles
                      buttonTitle:(NSString *)buttonTitle
                          myBlcok:(TouchButton)myBlcok
{
    if (self = [super init]) {
        if (superView == nil) superView = [UIApplication sharedApplication].keyWindow;
        
        [superView addSubview:self];
        self.imageName = imageName;
        self.labelTitleArr = labTitles;
        self.btnTitle = buttonTitle;
        self.myBlock = myBlcok;
        self.centerX = superView.bounds.size.width * 0.5;
        self.centerY = superView.bounds.size.height * 0.5;

    }
    return self;
}


- (void)setupViewF
{
    self.centerX = self.superview.bounds.size.width * 0.5;
    self.centerY = self.superview.bounds.size.height * 0.5;

    
    NSMutableArray *viewWArr = [NSMutableArray array];
    NSMutableArray *viewHArr = [NSMutableArray array];
    
    CGFloat reBtnY = 0;
    self.imgView.centerX = self.bounds.size.width * 0.5;
    self.imgView.y = 0;
    [viewWArr addObject:@(self.imgView.width)];
    [viewHArr addObject:@(self.imgView.bottom)];
    
    reBtnY = CGRectGetMaxY(self.imgView.frame);
    
    if (self.labelTitleArr.count >= 1) {
        self.upLabel.size = [self.labelTitleArr[0] sizeWithTextFont:JYEmptyViewLabelTitleFont maxWidth:ScreenWidth];
        self.upLabel.centerX = self.imgView.centerX;
        self.upLabel.y = CGRectGetMaxY(self.imgView.frame) + 48;
        
        [viewWArr addObject:@(self.upLabel.width)];
        [viewHArr addObject:@(self.upLabel.bottom)];
        reBtnY = CGRectGetMaxY(self.upLabel.frame);
    } else {
        self.upLabel.frame = CGRectZero;
    }
    
    if (self.labelTitleArr.count >= 2) {
        self.downLabel.size = [self.labelTitleArr[1] sizeWithTextFont:JYEmptyViewLabelTitleFont maxWidth:ScreenWidth];
        self.downLabel.centerX = self.imgView.centerX;
        self.downLabel.y = CGRectGetMaxY(self.upLabel.frame) + 10;
        [viewWArr addObject:@(self.downLabel.width)];
        [viewHArr addObject:@(self.downLabel.bottom)];
        
        reBtnY = CGRectGetMaxY(self.downLabel.frame);
    } else {
        self.downLabel.frame = CGRectZero;
    }
    
    if (self.btnTitle) {
//        CGSize btnSize = [self.btnTitle sizeWithTextFont:JYEmptyViewButtonTitleFont];
//        self.reBtn.width = btnSize.width + 2 *JYUnvMagin_25;
//        self.reBtn.height = btnSize.height + 2 * JYUnvMagin_10;
        self.reBtn.size = [self.reBtn backgroundImageForState:UIControlStateNormal].size;
        self.reBtn.centerX = self.imgView.centerX;
        self.reBtn.y = reBtnY + 40;
        [viewWArr addObject:@(self.reBtn.width)];
        [viewHArr addObject:@(self.reBtn.bottom)];
    } else {
        self.reBtn.frame = CGRectZero;
    }
    
    [viewWArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 floatValue] < [obj2 floatValue];
    }];
    [viewHArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 floatValue] < [obj2 floatValue];
    }];
    
    // 数组不可能为空
    self.width = [viewWArr[0] floatValue];
    self.height = [viewHArr[0] floatValue];
}

#pragma mark- set方法


- (void)setBtnTitle:(NSString *)btnTitle
{
    _btnTitle = btnTitle;
    [self.reBtn setTitle:btnTitle forState:UIControlStateNormal];
    [self setupViewF];
}


- (void)setLabelTitleArr:(NSArray *)labelTitleArr
{
    _labelTitleArr = labelTitleArr;
    if (self.labelTitleArr.count >= 1) {
        self.upLabel.text = self.labelTitleArr[0];
    }
    if (self.labelTitleArr.count >= 2) {
        self.downLabel.text = self.labelTitleArr[1];
    }
    
    [self setupViewF];
}


- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    [self setupViewF];
}



#pragma mark- 监听方法

- (void)reBtnClick:(UIButton *)btn
{
    if (_myBlock) {
        _myBlock(self.reBtn);
    }
}


#pragma mark- 代理方法 Delegate



#pragma mark- 其他方法


@end
