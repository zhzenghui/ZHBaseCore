//
//  UYFile.h
//  ruby-china-ios
//
//  Created by zeng hui on 2017/3/28.
//  Copyright © 2017年 yuenvshen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UYFile : NSObject
//    url / save key
//    local path
//    upyun_status   0 / 1
//    server_status    0 / 1
//    mimetype
//    file_size
//    extParams
///

@property NSString *name;
@property NSString *url;
@property NSString *local_path;
@property NSString *mimetype;
@property NSString *file_size;
@property NSString *extParams;

@property NSInteger upyun_status;
@property NSInteger server_status;
@property NSInteger status;

@end
