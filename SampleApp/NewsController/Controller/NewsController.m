//
//  NewsController.m
//  SampleApp
//
//  Created by 程广 on 2020/5/17.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "NewsController.h"
#import "GTNormalTableViewCell.h"
#import "GTDetailViewController.h"
#import "GTDeleteCellView.h"
#import "GTListLoader.h"
#import "GTListItem.h"



@interface NewsController ()<UITableViewDataSource, UITableViewDelegate, GTNormalTableViewCellDelegate>
@property(nonatomic,strong,readwrite) UITableView *tableView;
@property(nonatomic,strong,readwrite) NSArray *dataArray;
@property(nonatomic,strong,readwrite) GTListLoader *loderList;



@end

@implementation NewsController


- (instancetype) init {
    self = [super init];
    if(self) {
        self.tabBarItem.title = @"新闻";
    }
    return self;
}
 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[GTNormalTableViewCell class] forCellReuseIdentifier:@"id"];
    [self.view addSubview:tableView];
    self.loderList = [[GTListLoader alloc] init];
    // 处理self 防止循环引用
    __weak typeof(self) wself = self;
    [self.loderList loadListDataWithFinishBlock:^(BOOL success, NSArray<GTListItem *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
    }];
}


#pragma mark - UITableViewDelegate

// 设置tableview cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


// 选中一个cell的 delegete 回调
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", [NSString stringWithFormat:@"%@",@(indexPath.row)]);
    GTListItem *item = [self.dataArray objectAtIndex:indexPath.row];
    GTDetailViewController *controller = [[GTDetailViewController alloc]initWithUrlString: item.articleUrl];
    controller.title = [NSString stringWithFormat:@"余沙沙 ---- %@", @(indexPath.row)];
    [self.navigationController pushViewController: controller animated:YES];
    
    // 点击的时候保存一个key
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:item.uniqueKey];
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
                
        return self.dataArray.count;
}

// 缓存渲染一个cell的 delegete 回调
- (GTNormalTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"id" forIndexPath:indexPath];
    NSLog(@"~~~~~~~~~~~~~~~~~%ld",indexPath.row);
    if(cell == nil) {
        cell = [[GTNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
    cell.delegate = self;
    [cell layoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

// 点击删除按钮的delegate 回调
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton {
    //  创建view
   GTDeleteCellView *deleteView =   [[GTDeleteCellView alloc] initWithFrame:self.view.bounds];

   CGRect rect =[tableViewCell convertRect:deleteButton.frame toView:nil];

    __weak typeof(self) wself = self;
    [deleteView showDeleteViewFromPonit:rect.origin clickBlock:^{
        __strong typeof(wself)strongSelf = wself;
        [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationFade];
    }];
}

@end
