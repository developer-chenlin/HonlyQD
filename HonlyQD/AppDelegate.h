//
//  AppDelegate.h
//  HonlyQD
//
//  Created by 陈林 on 2017/11/8.
//  Copyright © 2017年 陈林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) QDViewController *tabBarController;

@end

