//
//  UYFileManage.h
//  ruby-china-ios
//
//  Created by zeng hui on 2017/3/28.
//  Copyright © 2017年 yuenvshen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UYFile.h"

@interface UYFileManage : NSObject


- (void)testAddFile;

- (void)addFile:(UYFile *)file;
- (void)updateFile:(UYFile *)file;
- (void)deleteFile:(UYFile *)file;


- (void)createTask:(UYFile *)file;
- (void)upYunTaskComplete:(UYFile *)file;
- (void)serverTaskComplete:(UYFile *)file;

@end
