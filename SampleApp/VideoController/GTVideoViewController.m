//
//  GTVideoViewController.m
//  SampleApp
//
//  Created by 程广 on 2020/5/17.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "GTVideoViewController.h"

@interface GTVideoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
 
@implementation GTVideoViewController

- (instancetype) init {
    self = [super init];
    if(self) {
        self.tabBarItem.title = @"视屏";
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
    flowLayout.itemSize = CGSizeMake((self.view.frame.size.width - 10)/2 , 300);
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame: self.view.bounds collectionViewLayout:flowLayout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"11111"];
    
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"11111" forIndexPath:indexPath ];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.item %3 == 0) {
        return CGSizeMake(self.view.frame.size.width, 100);
    }else {
        return CGSizeMake((self.view.frame.size.width - 10)/2, 300);
    }
    
}
@end
