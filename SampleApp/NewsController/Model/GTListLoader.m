//
//  GTListLoader.m
//  SampleApp
//
//  Created by 程广 on 2020/5/31.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "GTListLoader.h"
#import "GTListItem.h"
#import <AFNetworking.h>


@implementation GTListLoader

- (void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock {
    
//    NSArray<GTListItem *> *listData = [self _readDataFromLocal];
//    if (listData) {
//        finishBlock(YES,listData);
//    }
//    
    
    NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
    NSURL *listUrl = [NSURL URLWithString:urlString];
    
    //系统自带的请求方式
    __unused NSURLRequest *listRequest = [NSURLRequest requestWithURL: listUrl];
    NSURLSession *session = [NSURLSession sharedSession];
    __weak typeof(self) weakSelf = self;
    NSURLSessionTask *dataTask = [session dataTaskWithURL:listUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSError *jsonError;
        __unused id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
#warning 类型的检查
        NSArray *dataArray = [((NSDictionary *)[((NSDictionary *)jsonObj) objectForKey:@"result"]) objectForKey:@"data"];
        NSMutableArray *listItemArray = @[].mutableCopy;
        for (NSDictionary *info in dataArray) {
            GTListItem *listItem = [[GTListItem alloc] init];
            [listItem configWithDictionary:info];
            [listItemArray addObject:listItem];
        }
        // 存储数据
        [weakSelf _archiveListDataWithArray:listItemArray.copy];

        // 回调到主线程中
        dispatch_async(dispatch_get_main_queue(), ^{
               if(finishBlock) {
                     finishBlock(error == nil,listItemArray.copy);
                 }
        });
    }];
    [dataTask resume];
    
//
//    [[AFHTTPSessionManager manager] GET:urlString parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//    } success:
//     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"success");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"failure");
//    }];
}


#pragma mark private method

- (NSArray<GTListItem *> *)_readDataFromLocal{
    NSArray *pathArry =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [pathArry firstObject];
        NSString *listDataPath = [cachePath stringByAppendingString:@"GTData/list"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSData *readListData = [fileManager contentsAtPath:listDataPath];
        // 反序列化
        id unarchiveObject = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[GTListItem class], nil] fromData:readListData error:nil];
    if ([unarchiveObject isKindOfClass:[NSArray class]] && [unarchiveObject count] > 0) {
        return (NSArray<GTListItem *> *)unarchiveObject;
    }
    return nil;
}


- (void)_archiveListDataWithArray:(NSArray<GTListItem *> *)array {
    NSArray *pathArry =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArry firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 创建文件
    NSString *listDataPath = [cachePath stringByAppendingString:@"GTData/list"];
    
    // 序列化存入
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
    
    NSData *readListData = [fileManager contentsAtPath:listDataPath];
    
    // 反序列化
    id unarchiveObject = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[GTListItem class], nil] fromData:readListData error:nil];
    
//    //查询
//    BOOL fileExist = [fileManager fileExistsAtPath:listDataPath];
//
//    //删除
//    if (fileExist) {
//        [fileManager removeItemAtPath:listDataPath error:nil];
//    }
}


@end
