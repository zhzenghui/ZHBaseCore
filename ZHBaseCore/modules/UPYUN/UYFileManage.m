//
//  UYFileManage.m
//  ruby-china-ios
//
//  Created by zeng hui on 2017/3/28.
//  Copyright © 2017年 yuenvshen. All rights reserved.
//

#import "UYFileManage.h"

@implementation UYFileManage


- (void)testAddFile {
    
    NSString *fileUrl =  [NSTemporaryDirectory() stringByAppendingPathComponent:@""];
    NSLog(@"%@", fileUrl);
    
    UYFile *file = [[UYFile alloc] init];
    file.url = @"url";
    file.local_path = @"loc url";
    file.upyun_status = 0;
    file.server_status = 0;
//    
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//        [realm addObject:file];
//    }];

//    [self createTask:file];
//    [self upYunTaskComplete:file];
//    
//    [self taskMissionCompleted:file];
}

- (UYFile *)getFile:(NSString *)url{

//    NSString *where = [NSString stringWithFormat:@"url == '%@'", url];
//    UYFile *file = [[UYFile objectsWhere:where] firstObject];
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//    }];
//
    UYFile *file = [self getFile:url];

    return file;
}

- (void)addFile:(UYFile *)file {
    
}
- (void)updateFile:(UYFile *)file {
//    UYFile *getFile = [self getFile:file.url];

//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//        getFile.upyun_status = file.upyun_status;
//        getFile.server_status = file.server_status;
//        getFile.status = file.status;
//    }];
}
- (void)deleteFile:(UYFile *)file {
    
}


- (void)createTask:(UYFile *)file {
    
    UYFile *getFile = [self getFile:file.url];
    
    if (getFile) {
//        已经存在了
//    NSLog(@"%@", getFile);    
    }
    else {
//        RLMRealm *realm = [RLMRealm defaultRealm];
//        [realm transactionWithBlock:^{
//            [realm addObject:file];
//        }];
    }

}

- (void)upYunTaskComplete:(UYFile *)file  {
    file.upyun_status = 1;
    [self updateFile:file];
}
 

- (void)serverTaskComplete:(UYFile *)file {
    file.server_status = 1;
    [self updateFile:file];
}

- (void)taskMissionCompleted:(UYFile *)file {
    file.status = 1;
    [self updateFile:file];
}

@end
