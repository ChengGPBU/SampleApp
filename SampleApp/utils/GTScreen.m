//
//  GTScreen.m
//  SampleApp
//
//  Created by 程广 on 2020/6/14.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "GTScreen.h"

@implementation GTScreen

//iphone xs max
+ (CGSize)sizeFor65Inch{
    return CGSizeMake(414,896);
}

//iphone xr
+ (CGSize)sizeFor61Inch{
    return CGSizeMake(414,896);
}


//iphone x
+ (CGSize)sizeFor58Inch{
    return CGSizeMake(375,812);
}


@end
