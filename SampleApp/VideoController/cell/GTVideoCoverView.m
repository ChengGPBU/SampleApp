//
//  GTVideoCoverView.m
//  SampleApp
//
//  Created by 程广 on 2020/6/13.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "GTVideoCoverView.h"


@interface GTVideoCoverView()
@property(nonatomic,strong,readwrite) UIImageView *coverView;
@property(nonatomic,strong,readwrite) UIImageView *playButton;

@end

@implementation GTVideoCoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview: ({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            _coverView;
        })];
        
        
        [self addSubview: ({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-50)/2, (frame.size.width-50)/2, 50, 50)];
            _playButton.image = [UIImage imageNamed: @""];
            _playButton;
        })];
        
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
    }
    return self;
}


#pragma mark -
- (void)_tapToPlay{
    
}

@end
