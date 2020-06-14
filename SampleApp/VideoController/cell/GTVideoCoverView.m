//
//  GTVideoCoverView.m
//  SampleApp
//
//  Created by 程广 on 2020/6/13.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "GTVideoCoverView.h"
#import <AVFoundation/AVFoundation.h>
#import "GTVideoToolBar.h"



@interface GTVideoCoverView()
@property(nonatomic,strong,readwrite) UIImageView *coverView;  // 初始化的播放背景
@property(nonatomic,strong,readwrite) UIImageView *playButton;  // 播放开始那妞
@property(nonatomic,strong,readwrite) NSString *videoUrl;  // 视频资源

@property(nonatomic,strong,readwrite) AVPlayerItem *avPlayerItem;  // 播放资源
@property(nonatomic,strong,readwrite) AVPlayer *avPlayer;  // 播放播放控制
@property(nonatomic,strong,readwrite) AVPlayerLayer *avPlayerLayer;  // 播放层


@property(nonatomic,strong,readwrite) GTVideoToolBar *toolbar;  // toolbar






@end

@implementation GTVideoCoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview: ({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - GTVideoToolBarHeight)];
            _coverView;
        })];
        
        
        [self addSubview: ({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-50)/2, (frame.size.height-50-GTVideoToolBarHeight)/2, 50, 50)];
            _playButton.image = [UIImage imageNamed: @"icon_pickup"];
            _playButton;
        })];
        
        [self addSubview: ({
            _toolbar = [[GTVideoToolBar alloc]initWithFrame:CGRectMake(0, _coverView.bounds.size.height, frame.size.width, GTVideoToolBarHeight)];
            _toolbar;
          })];
        
        
        
        // 添加手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
    }
    
    // 注册notifiycation
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_avPlayerItem removeObserver:self forKeyPath:@"status"];
    [_avPlayerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];

}


#pragma mark - public method
- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl {
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _videoUrl = videoUrl;
    // 添加toolbar
    [_toolbar layoutWithModel:nil];
}

#pragma mark - action
- (void)_tapToPlay{
    
    NSURL *videoUrl = [NSURL URLWithString:_videoUrl];
    
    AVAsset *asset = [AVAsset assetWithURL:videoUrl];
    _avPlayerItem = [AVPlayerItem playerItemWithAsset:asset]; //M层
    //添加KVO 是否read状态监听
    [_avPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_avPlayerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    CMTime duration =  _avPlayerItem.duration;
    CGFloat videoDuration = CMTimeGetSeconds(duration);
    _avPlayer = [AVPlayer playerWithPlayerItem:_avPlayerItem]; // C层
    [_avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSLog(@"播放进度： %@", @(CMTimeGetSeconds(time)));
    }];
    _avPlayerLayer  =[AVPlayerLayer playerLayerWithPlayer:_avPlayer]; // V层
    //设置大小
    _avPlayerLayer.frame = _coverView.bounds;
    // 添加到占位图中
    [_coverView.layer addSublayer:_avPlayerLayer];
    
    NSLog(@"");
}
// 播放结束 释放资源
- (void)_handlePlayEnd{
    NSLog(@"");
//    [_avPlayerLayer removeFromSuperlayer];
//    _avPlayerItem = nil;
//    _avPlayer = nil;
    // 返回到第0秒
    [_avPlayer seekToTime: CMTimeMake(0, 1)];
    [_avPlayer play];
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        // 可以播放
        if (((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerStatusReadyToPlay) {
            [_avPlayer play];
        }
        if (((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerStatusFailed) {
            
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSLog(@"缓冲：%@",[change objectForKey:NSKeyValueChangeNewKey]);
    }
}


@end
