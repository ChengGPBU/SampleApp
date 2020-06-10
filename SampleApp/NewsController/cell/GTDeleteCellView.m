//
//  GTDeleteCellView.m
//  SampleApp
//
//  Created by 程广 on 2020/5/27.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "GTDeleteCellView.h"


@interface GTDeleteCellView()

@property(nonatomic,strong,readwrite) UIView *backgroundView;
@property(nonatomic,strong,readwrite) UIButton *deleteButton;
@property(nonatomic,copy,readwrite) dispatch_block_t deleteBlock;


@end

@implementation GTDeleteCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview: ({
            _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
            _backgroundView.backgroundColor = [UIColor blackColor];
            _backgroundView.alpha = 0.5;
            // 添加手势识别
            [_backgroundView addGestureRecognizer:({
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDeleteView)];
                tapGesture;
            })];
            _backgroundView;
        })];
        
        
        [self addSubview: ({
            _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            [_deleteButton addTarget:self action:@selector(_clickButton) forControlEvents:UIControlEventTouchUpInside];
            _deleteButton.backgroundColor = [UIColor blueColor];            
            _deleteButton;
        })];
    }
    return self;
}


- (void)showDeleteView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
//    
////    [UIView animateWithDuration:1.f animations:^{
////        self.deleteButton.frame = CGRectMake((self.bounds.size.width-200)/2, (self.bounds.size.height-200)/2, 200, 200);
////    }];
//    
    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.deleteButton.frame = CGRectMake((self.bounds.size.width-200)/2, (self.bounds.size.height-200)/2, 200, 200);
    } completion:^(BOOL finished) {
        NSLog(@"animation completion");
    }];
}


- (void)showDeleteViewFromPonit:(CGPoint) point clickBlock:(dispatch_block_t) clickBlock{
    _deleteButton.frame = CGRectMake(point.x, point.y, 0, 0);
    _deleteBlock = [clickBlock copy];  // 点击的时候持有block

        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
    //    [UIView animateWithDuration:1.f animations:^{
    //        self.deleteButton.frame = CGRectMake((self.bounds.size.width-200)/2, (self.bounds.size.height-200)/2, 200, 200);
    //    }];
        
        [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    self.deleteButton.frame = CGRectMake((self.bounds.size.width-200)/2, (self.bounds.size.height-200)/2, 200, 200);
        } completion:^(BOOL finished) {
            NSLog(@"animation completion");
        }];
}

- (void)dismissDeleteView{
    self.removeFromSuperview;
}

- (void)_clickButton {
    if(_deleteBlock) {
        _deleteBlock();
    }
    self.removeFromSuperview;
}

@end
