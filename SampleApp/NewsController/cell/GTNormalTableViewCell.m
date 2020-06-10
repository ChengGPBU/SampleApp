//
//  GTNormalTableViewCell.m
//  SampleApp
//
//  Created by 程广 on 2020/5/18.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "GTNormalTableViewCell.h"
#import "GTListItem.h"

@interface GTNormalTableViewCell()

@property(nonatomic,strong,readwrite) UILabel *titleLabel;
@property(nonatomic,strong,readwrite) UILabel *sourceLabel;
@property(nonatomic,strong,readwrite) UILabel *commentLabel;
@property(nonatomic,strong,readwrite) UILabel *timeLabel;
@property(nonatomic,strong,readwrite) UIImageView *rightImageView;
@property(nonatomic,strong,readwrite) UIButton *button;


@end


@implementation GTNormalTableViewCell



-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        [self.contentView addSubview:({
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 270, 50)];
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel.numberOfLines = 2;
            self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            self.titleLabel;
        })];
        
        [self.contentView addSubview:({
            self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 50, 20)];
            self.sourceLabel.font = [UIFont systemFontOfSize:12];
            self.sourceLabel.textColor = [UIColor grayColor];
            self.sourceLabel;
        })];
        
        [self.contentView addSubview:({
            self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, 50, 20)];
            self.commentLabel.font = [UIFont systemFontOfSize:12];
            self.commentLabel.textColor = [UIColor grayColor];
            self.commentLabel;
        })];
        
        [self.contentView addSubview:({
            self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 70, 50, 20)];
            self.timeLabel.font = [UIFont systemFontOfSize:12];
            self.timeLabel.textColor = [UIColor grayColor];
            self.timeLabel;
        })];
        
        [self.contentView addSubview: ({
            self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 15, 100, 70)];
            self.rightImageView.backgroundColor = [UIColor redColor];
            self.rightImageView;
        })];

        [self.contentView addSubview: ({
            self.button = [[UIButton alloc] initWithFrame:CGRectMake(210, 70, 30, 20)];
            [self.button setTitle:@"x" forState:UIControlStateNormal];
            [self.button setTitle:@"y" forState:UIControlStateHighlighted];
            [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
            self.button.backgroundColor = [UIColor blueColor];
            self.button.layer.cornerRadius = 10;
            self.button.layer.masksToBounds = YES;
            self.button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            self.button.layer.borderWidth = 2;
            self.button;
        })];

        
    }
    return self;
}

- (void) layoutTableViewCellWithItem:(GTListItem *)item {
    BOOL hasRead = [[NSUserDefaults standardUserDefaults] boolForKey:item.uniqueKey];
    if (hasRead) {
        self.titleLabel.textColor = [UIColor grayColor];
    }else {
        self.titleLabel.textColor = [UIColor blackColor];
    }
    self.titleLabel.text = item.title;

    self.sourceLabel.text = item.authorName;
    [self.sourceLabel sizeToFit];

    self.commentLabel.text = item.category;
    [self.commentLabel sizeToFit];
    self.commentLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width+15 , self.commentLabel.frame.origin.y, self.commentLabel.frame.size.width,self.commentLabel.frame.size.height);

    self.timeLabel.text = item.date;
    [self.timeLabel sizeToFit];
    self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width+15 , self.timeLabel.frame.origin.y, self.timeLabel.frame.size.width,self.timeLabel.frame.size.height);

#warning
    // 获取一个全局队列
    dispatch_queue_global_t downLoadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 获取一个主队列
    dispatch_queue_main_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(downLoadQueue, ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.picUrl]]];
        dispatch_async(mainQueue, ^{
            self.rightImageView.image = image;
        });
    });
}


-(void) buttonClick {
    // -(BOOL) respondsToSelector: selector 用来判断是否有以某个名字命名的方法(被封装在一个selector的对象里传递)
    if(self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:clickDeleteButton:)]) {
        [self.delegate tableViewCell:self clickDeleteButton:self.button]; 
         NSLog(@"delete button onClick");
    }
}

@end
