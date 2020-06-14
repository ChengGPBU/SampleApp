//
//  GTSplashView.m
//  SampleApp
//
//  Created by 程广 on 2020/6/14.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "GTSplashView.h"
#import "GTScreen.h"


@interface GTSplashView()
@property(nonatomic,strong,readwrite) UIButton *button;

@end

@implementation GTSplashView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@""];
        [self addSubview:({
            _button = [[UIButton alloc] initWithFrame:UIRect(330, 100, 60, 40)];
            _button.backgroundColor = [UIColor lightGrayColor];
            [_button setTitle:@"跳过" forState:UIControlStateNormal];
            [_button addTarget:self action:@selector(_removeSplashView) forControlEvents:UIControlEventTouchUpInside];
            _button;
        })];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)_removeSplashView{
    
}

@end
