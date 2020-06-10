//
//  AppDelegate.m
//  SampleApp
//
//  Created by 程广 on 2020/5/14.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
           
//           UITabBarController *tabbarController = [[UITabBarController alloc] init];
//           
//           UIViewController *controller1 = [[UIViewController alloc] init];
//           controller1.view.backgroundColor = [UIColor redColor];
//           controller1.tabBarItem.title = @"新闻";
//           controller1.tabBarItem.image = [UIImage imageNamed: @"Home"];
//
//           
//           UIViewController *controller2 = [[UIViewController alloc] init];
//           controller2.view.backgroundColor = [UIColor yellowColor];
//           controller2.tabBarItem.title = @"视屏";
//
//           UIViewController *controller3 = [[UIViewController alloc] init];
//           controller3.view.backgroundColor = [UIColor greenColor];
//           controller3.tabBarItem.title = @"推线";
//
//           UIViewController *controller4 = [[UIViewController alloc] init];
//           controller4.view.backgroundColor = [UIColor lightGrayColor];
//           controller4.tabBarItem.title = @"我的";
//           
//           [tabbarController setViewControllers: @[controller2,controller2,controller3,controller4]];



    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.


}


@end
