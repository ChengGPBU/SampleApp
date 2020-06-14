//
//  SceneDelegate.m
//  SampleApp
//
//  Created by 程广 on 2020/5/14.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "SceneDelegate.h"
#import "NewsController.h"
#import "GTVideoViewController.h"
#import "GTRecommendViewController.h"



@interface SceneDelegate ()<UITabBarControllerDelegate>

@end
 
@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

            UIWindowScene *windowScene = (UIWindowScene *)scene;
            self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
            self.window.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
            UITabBarController *tabbarController = [[UITabBarController alloc] init];
    
              NewsController *controller1 = [[NewsController alloc] init];
              GTVideoViewController *controller2 = [[GTVideoViewController alloc] init];
              GTRecommendViewController *controller3 = [[GTRecommendViewController alloc] init];
    

              UIViewController *controller4 = [[UIViewController alloc] init];
              controller4.view.backgroundColor = [UIColor lightGrayColor];
              controller4.tabBarItem.title = @"我的";

              [tabbarController setViewControllers: @[controller1,controller2,controller3,controller4]];
    
              tabbarController.delegate = self;
    
    
              UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabbarController];
    
    
    
//
    
            self.window.rootViewController = navigationController;
            [self.window setBackgroundColor:[UIColor whiteColor]];
            [self.window makeKeyAndVisible];
    
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSLog(@"shouldSelectViewController",tabBarController);
    return  YES;
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"didSelectViewController");
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    
    
   
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
