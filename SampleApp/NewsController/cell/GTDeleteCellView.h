//
//  GTDeleteCellView.h
//  SampleApp
//
//  Created by 程广 on 2020/5/27.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTDeleteCellView : UIView
- (void)showDeleteView;
- (void)dismissDeleteView;
- (void)showDeleteViewFromPonit:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock;
@end

NS_ASSUME_NONNULL_END
