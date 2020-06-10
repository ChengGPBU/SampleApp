//
//  GTNormalTableViewCell.h
//  SampleApp
//
//  Created by 程广 on 2020/5/18.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import <UIKit/UIKit.h>

 
NS_ASSUME_NONNULL_BEGIN

@class GTListItem;

// 类似java中的接口
@protocol GTNormalTableViewCellDelegate <NSObject>
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;
@end



// 定义类
@interface GTNormalTableViewCell : UITableViewCell

@property(nonatomic,weak,readwrite) id<GTNormalTableViewCellDelegate> delegate;

- (void)layoutTableViewCellWithItem:(GTListItem *)item;

@end

NS_ASSUME_NONNULL_END
