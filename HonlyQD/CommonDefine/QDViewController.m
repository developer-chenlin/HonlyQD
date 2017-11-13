//
//  QDViewController.m
//  HonlyQD
//
//  Created by 陈林 on 2017/11/8.
//  Copyright © 2017年 陈林. All rights reserved.
//

#import "QDViewController.h"

#import "MusicDBTableViewController.h"

@interface QDViewController ()

@end

@implementation QDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setValue:[[QDTabbar alloc] init] forKey:@"tabBar"];

     [self addAllChildViewController];
}



- (void)addAllChildViewController {
    
    MusicDBTableViewController *musicVC = [[MusicDBTableViewController alloc] init];
    musicVC.view.backgroundColor = [UIColor grayColor];
     [self addChildViewController:musicVC title:@"音乐" imageNamed:@"tabBar_home"];

    UIViewController *activityVC = [[UIViewController alloc] init];
    activityVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:activityVC title:@"活动" imageNamed:@"tabBar_activity"];
    
    UIViewController *findVC = [[UIViewController alloc] init];
    findVC.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:findVC title:@"发现" imageNamed:@"tabBar_find"];
    
    UIViewController *mineVC = [[UIViewController alloc] init];
    mineVC.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:mineVC title:@"我的" imageNamed:@"tabBar_mine"];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 添加某个 childViewController
- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
    vc.navigationItem.title = title;
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageNamed];
    
    [self addChildViewController:nav];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
