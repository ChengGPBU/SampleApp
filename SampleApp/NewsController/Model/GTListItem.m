//
//  GTListItem.m
//  SampleApp
//
//  Created by 程广 on 2020/5/31.
//  Copyright © 2020 chengguang. All rights reserved.
//

#import "GTListItem.h"

@implementation GTListItem


#pragma mark - NSSecureCoding

- (nullable instancetype)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if(self) {
        self.category = [coder decodeObjectForKey:@"category"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.picUrl = [coder decodeObjectForKey:@"picUrl"];
        self.uniqueKey = [coder decodeObjectForKey:@"uniqueKey"];
        self.date = [coder decodeObjectForKey:@"date"];
        self.authorName = [coder decodeObjectForKey:@"authorName"];
        self.articleUrl = [coder decodeObjectForKey:@"articleUrl"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.category forKey:@"category"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.picUrl forKey:@"picUrl"];
    [coder encodeObject:self.uniqueKey forKey:@"uniqueKey"];
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.authorName forKey:@"authorName"];
    [coder encodeObject:self.articleUrl forKey:@"articleUrl"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}



- (void)configWithDictionary:(NSDictionary *)dictionary {

#warning 类型是否匹配
    self.category = [dictionary objectForKey: @"category"];
    self.title = [dictionary objectForKey: @"title"];
    self.picUrl = [dictionary objectForKey: @"thumbnail_pic_s"];
    self.uniqueKey = [dictionary objectForKey: @"uniquekey"];
    self.date = [dictionary objectForKey: @"date"];
    self.authorName = [dictionary objectForKey: @"author_name"];
    self.articleUrl = [dictionary objectForKey: @"url"];
}

@end
