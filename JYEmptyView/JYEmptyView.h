//
//  JYEmptyView.h
//  mingshi
//
//  Created by  李辉 on 15/2/4.
//  Copyright (c) 2015年 绩优堂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchButton)(UIButton *btn);

@interface JYEmptyView : UIView



/**
 *  生成一张带文字和按钮的占位图片 最多生成两个label 一个按钮
 *
 *  @param superView   需要把这张占位图添加到那个控件上
 *  @param imageName   占位图的名字 不需要的话传nil
 *  @param labTitles   label 的文字, 需要传一个数组, 数组里面是字符串, 最多取数组的前两个 不需要的话传 nil
 *  @param buttonTitle 按钮的文字 不需要的话传 nil
 *  @param myBlcok     按钮需要执行的操作
 *
 *  @return 返回一个JYEmptyView 可以不接收.
 */
+ (instancetype)emptyViewWithSuperView:(UIView *)superView
                             imageName:(NSString *)imageName
                             labTitles:(NSArray *)labTitles
                           buttonTitle:(NSString *)buttonTitle
                               myBlcok:(TouchButton)myBlcok;


/**
 *  隐藏 alert
 */
+ (void)hideJYEmptyView:(UIView *)superView;


@end
