//
//  UpYunHelper.h
//  ruby-china-ios
//
//  Created by zeng hui on 2017/1/11.
//  Copyright © 2017年 yuenvshen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UpYunHelperDelegate <NSObject>

- (void)uploadSuccess:(NSString *)msg;
- (void)uploadEnd:(NSString *)msg;
- (void)uploadError:(NSString *)msg;

@end

@interface UpYunHelper : NSObject


@property(nonatomic, weak) id<UpYunHelperDelegate> delegate;


+ (instancetype)sharedManager;
/// 上传文件
///
/// - Parameters:
///   - path: 上传文件的路径

- (void)uploadData:(NSData *)data saveKey:(NSString *)saveKey;


- (NSString * )getSaveKeyWith:(NSString *)suffix;


- (void)clearCache;
@end
