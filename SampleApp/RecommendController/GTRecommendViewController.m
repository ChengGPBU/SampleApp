//
//  GTRecommendViewController.m
//  SampleApp
//
//  Created by 程广 on 2020/5/17.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "GTRecommendViewController.h"

@interface GTRecommendViewController ()<UIGestureRecognizerDelegate>

@end

@implementation GTRecommendViewController


- (instancetype) init {
    self = [super init];
    if(self) {
        self.tabBarItem.title = @"推荐";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor linkColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*5, self.view.bounds.size.height);
    
    NSArray *colorArray = @[[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor lightGrayColor],[UIColor grayColor]];
    for (int i = 0; i < 5; i++) {
        [scrollView addSubview:({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollView.bounds.size.width*i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
            [view addSubview:({
                UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
                innerView.backgroundColor= [UIColor blackColor];
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(innerViewClick)];
                tapGesture.delegate = self;
                [innerView addGestureRecognizer:tapGesture];
                innerView;
            })];
            view.backgroundColor = [colorArray objectAtIndex:i];
        view;
        })];
    }
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
}


-(void) innerViewClick {
    NSLog(@"InnerViewClick");
}

// 是否应该响应手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
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
