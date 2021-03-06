//
//  QDTabbar.m
//  HonlyQD
//
//  Created by 陈林 on 2017/11/8.
//  Copyright © 2017年 陈林. All rights reserved.
//

#import "QDTabbar.h"

@interface QDTabbar ()

@property (nonatomic, strong) UIButton *centerBtn;

@end

@implementation QDTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = [UIColor redColor];  //设置tabBarItem选中的颜色
        [self addSubview:self.centerBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonArray addObject:view];
        }
    }
    CGFloat barWidth = self.bounds.size.width;
    CGFloat barHeight = self.bounds.size.height;
    CGFloat centerBtnWidth = CGRectGetWidth(self.centerBtn.frame);
    CGFloat centerBtnHeight = CGRectGetHeight(self.centerBtn.frame);
    
    //设置中间按钮的位置，居中，网上凸起一点点
    self.centerBtn.center = CGPointMake(barWidth/2, barHeight/2-centerBtnHeight/2 -5);
    //重新布局其他tabBarItem,平均分配其他tabBarItem的宽度
    CGFloat barItemWidth = (barWidth - centerBtnWidth) / tabBarButtonArray.count;
    //逐个布局tabBarItem，修改UITabBarButton的frame
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = view.frame;
        if (idx >= tabBarButtonArray.count /2) {
            frame.origin.x = idx * barItemWidth + centerBtnWidth;
        } else {
            frame.origin.x = idx * barItemWidth;
        }
        //重新设置宽度
        frame.size.width = barItemWidth;
        view.frame = frame;
    }];
    //把中间按钮放到试图最前面
    [self bringSubviewToFront:self.centerBtn];
}

- (void)clickCenterBtn:(UIButton *)btn {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"点击了中间的按钮" message:@"do something!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:action];
    // 可以这样获取tabBarController
    id delegate = [UIApplication sharedApplication].delegate;
    UITabBarController *tabBarController = [delegate tabBarController];
    
    [tabBarController.selectedViewController presentViewController:alertController animated:YES completion:nil];
}


#pragma mark
#pragma mark - Getter

- (UIButton *)centerBtn {
    if (_centerBtn == nil) {
        _centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [_centerBtn setImage:[UIImage imageNamed:@"cc"] forState:UIControlStateNormal];
        [_centerBtn addTarget:self action:@selector(clickCenterBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}




#pragma mark - UIViewGeometry
//重写hitTest方法，让超出tabBar部分也能响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.clipsToBounds || self.hidden  ||  self.alpha == .0f) {
        return nil;
    }
    UIView *result = [super hitTest: point withEvent:event];
    
    //如果时间发生在tabbar里面直接返回
    if (result) {
        return  result;
    }
    
    //遍历哪些超出的部分
    for (UIView *subView in self.subviews) {
        // 把这个坐标从tabbr的坐标系转换到subviews的坐标系
        CGPoint subPoint = [subView  convertPoint:point fromView:self];
        result = [subView hitTest:subPoint withEvent:event];
        //如果这些事件发生在subView里就直接返回
        if (result) {
            return result;
        }
    }
    return nil;
}





@end
