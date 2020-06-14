//
//  GTVideoViewController.m
//  SampleApp
//
//  Created by 程广 on 2020/5/17.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "GTVideoViewController.h"
#import "GTVideoCoverView.h"
#import "GTVideoToolBar.h"



@interface GTVideoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
 
@implementation GTVideoViewController

- (instancetype) init {
    self = [super init];
    if(self) {
        self.tabBarItem.title = @"视频";
        self.tabBarItem.image = [UIImage imageNamed:@"icon_pickup"];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.minimumLineSpacing  = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width , self.view.bounds.size.width /16 * 9 + GTVideoToolBarHeight);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame: self.view.bounds collectionViewLayout:flowLayout];
    // 8 9 10 没有这个属性  不自动适配 手动适配
//    if (@available(iOS 11.0, *)) {
//        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        // Fallback on earlier versions
//    }
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[GTVideoCoverView class] forCellWithReuseIdentifier:@"GTVideoCoverView"];
    
    [self.view addSubview:collectionView];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GTVideoCoverView" forIndexPath:indexPath ];
    if ([cell isKindOfClass:[GTVideoCoverView class]]) {
        [((GTVideoCoverView * )cell) layoutWithVideoCoverUrl:@"icon_pickup" videoUrl:@"https://v-cdn.zjol.com.cn/280443.mp4"];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

//    if(indexPath.item %3 == 0) {
//        return CGSizeMake(self.view.frame.size.width, 100);
//    }else {
//        return CGSizeMake((self.view.frame.size.width - 10)/2, 300);
//    }
    
    return CGSizeMake(self.view.bounds.size.width , self.view.bounds.size.width /16 * 9 + GTVideoToolBarHeight);
    
}
@end
