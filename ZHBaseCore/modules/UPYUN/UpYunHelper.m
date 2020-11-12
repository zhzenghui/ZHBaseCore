//
//  UpYunHelper.m
//  ruby-china-ios
//
//  Created by zeng hui on 2017/1/11.
//  Copyright © 2017年 yuenvshen. All rights reserved.
//
//　   　　／＞　　フ
//　　  　|  　~　 ~ l
//　   　／` ミ＿xノ
//　　 /　 ヽ　　 ﾉ
//／￣|　　 |　|　|
//| (￣ヽ＿_ヽ_)__)
//＼二つ

#import "UpYunHelper.h"
//#import <UPYUN/UpYun.h>
#import "UpYunFormUploader.h"
#import "UpYunBlockUpLoader.h"

@interface UpYunHelper()

@property(nonatomic, strong) NSString *bucketName;
@property(nonatomic, strong) NSString *operator;
@property(nonatomic, strong) NSString *password;
@property(nonatomic, strong) NSString *fromepassword;

@property(nonatomic, assign) int       completeCount;
@property(nonatomic, assign) int       maxCount;

@property(nonatomic, strong, readonly) NSMutableArray *photosArray;
@property(nonatomic, strong) dispatch_queue_t concurrentPhotoQueue;

@end

@implementation UpYunHelper

+ (instancetype)sharedManager
{
    static UpYunHelper *sharedPhotoManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPhotoManager = [[UpYunHelper alloc] init];
        sharedPhotoManager->_photosArray = [NSMutableArray array];
        sharedPhotoManager->_completeCount = 0;
        sharedPhotoManager->_maxCount      = 0;
        // ADD THIS:
        sharedPhotoManager->_concurrentPhotoQueue = dispatch_queue_create("com.selander.GooglyPuff.photoQueue",
                                                                          DISPATCH_QUEUE_CONCURRENT);
    });
    
    return sharedPhotoManager;
}

- (NSArray *)photos
{
    __block NSArray *array; // 1
    dispatch_sync(self.concurrentPhotoQueue, ^{ // 2
        array = [NSArray arrayWithArray:self->_photosArray]; // 3
    });
    return array;
}

- (void)addPhoto:(NSString *)photo
{
    __weak typeof(self) weakSelf = self;
    
    if (photo) { // 1
        _maxCount++;
        dispatch_async(self.concurrentPhotoQueue, ^{ // 2
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.photosArray addObject:photo]; // 3
            dispatch_async(dispatch_get_main_queue(), ^{ // 4
//                [self postContentAddedNotification];
            });
        });
    }
}

- (void)removePhoto:(NSDictionary *)photo
{
    if (photo) { // 1
        _completeCount++;
        dispatch_async(self.concurrentPhotoQueue, ^{
            NSString *fileName = photo[@"ext-param"];
            NSLog(@"%@", fileName);
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                [self postContentAddedNotification];
            });
        });
    }
}


- (void)uploadSuccess:(NSDictionary *)responseBody {
    [self removePhoto:responseBody];
    NSString *str = [NSString stringWithFormat:@"已完成: %d/%d", _completeCount, _maxCount];
    [self.delegate uploadSuccess:str];

    NSLog(@"%@", str);
    if (_completeCount == _maxCount)
        [self uploadEnd:@"end"];

}

- (void)uploadEnd:(NSString *)msg{
    [self.delegate uploadEnd:msg];
    [self clearCache];
}
  
    
- (void)uploadError:(NSDictionary *)responseBody {
    NSLog(@"%@", responseBody);
    [self clearCache];
    [self.delegate uploadError:@" error "];
}

- (NSString *)info {
    
    return @"";
}

- (void)uploadData:(NSData *)data saveKey:(NSString *)saveKey {
    
    NSString *fileName = [saveKey componentsSeparatedByString:@"/"].lastObject;
    [self uploadDataForm:data fileName:fileName saveKey:saveKey];
}

// 断点续传
- (void)uploadDataBlock:(NSData *)data saveKey:(NSString *)saveKey {
    
}


#define XOR_KEY 0xBB

void xorString(unsigned char *str, unsigned char key)
{
    unsigned char *p = str;
    while( ((*p) ^=  key) != '\0')  p++;
}

- (void)testFunction
{
    unsigned char str[] = {(XOR_KEY ^ 'h'),
        (XOR_KEY ^ 'e'),
        (XOR_KEY ^ 'l'),
        (XOR_KEY ^ 'l'),
        (XOR_KEY ^ 'o'),
        (XOR_KEY ^ '\0')};
    xorString(str, XOR_KEY);
    static unsigned char result[6];
    memcpy(result, str, 6);
    NSLog(@"%s",result);      //output: hello
}

// 小文件上传
- (void)uploadDataForm:(NSData *)data fileName:(NSString *)name saveKey:(NSString *)sk {
    
    unsigned char str1[] = {
        (XOR_KEY ^ 'y'),
        (XOR_KEY ^ 'u'),
        (XOR_KEY ^ 'e'),
        (XOR_KEY ^ 'f'),
        (XOR_KEY ^ 'i'),
        (XOR_KEY ^ 'l'),
        (XOR_KEY ^ 'e'),
        (XOR_KEY ^ '\0')};
    xorString(str1, XOR_KEY);
    static unsigned char bucketName[8];
    memcpy(bucketName, str1, 8);
    
    unsigned char str2[] = {
        (XOR_KEY ^ 'y'),
        (XOR_KEY ^ 'u'),
        (XOR_KEY ^ 'e'),
        (XOR_KEY ^ 'f'),
        (XOR_KEY ^ 'i'),
        (XOR_KEY ^ 'l'),
        (XOR_KEY ^ 'e'),
        (XOR_KEY ^ 'w'),
        (XOR_KEY ^ 'e'),
        (XOR_KEY ^ 'b'),
        (XOR_KEY ^ 'a'),
        (XOR_KEY ^ 'p'),
        (XOR_KEY ^ 'p'),
        (XOR_KEY ^ 'm'),
        (XOR_KEY ^ 'a'),
        (XOR_KEY ^ 'n'),
        (XOR_KEY ^ 'a'),
        (XOR_KEY ^ 'g'),
        (XOR_KEY ^ 'e'),
        (XOR_KEY ^ 'r'),
        (XOR_KEY ^ '\0')};
    xorString(str2, XOR_KEY);
    static unsigned char operator[21];
    memcpy(operator, str2, 21);
    NSLog(@"%s",operator);
    
    _bucketName = @"yuefile";
    _operator   = @"yuefilewebappmanager";
    _password   = @"zaq1xsw2cde3!@#";

    
    __block NSData *fileData = data;
    __block NSString *fileName = name;
    __block NSString *saveKey = sk;
    NSLog(@"上传文件名：%@", saveKey);

    UpYunFormUploader *formUploader = [[UpYunFormUploader alloc] init];

    __weak typeof(self) weakSelf = self;
    
    [self addPhoto:fileName];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
        __strong typeof(weakSelf) strongSelf = weakSelf;
 
        [formUploader uploadWithBucketName:strongSelf.bucketName
                                  operator:strongSelf.operator
                                  password:strongSelf.password
                                  fileData:fileData
                                  fileName:fileName
                                   saveKey:saveKey
                           otherParameters:@{ @"ext-param": fileName} //@"x-upyun-meta-secret": @"upyunsecret",
                                   success:^(NSHTTPURLResponse *response, NSDictionary *responseBody) {
                                       dispatch_async(dispatch_get_main_queue(), ^{ // 2
                                           [self uploadSuccess:responseBody];
                                       });
                                   } failure:^(NSError *error, NSHTTPURLResponse *response, NSDictionary *responseBody) {
                                       dispatch_async(dispatch_get_main_queue(), ^{ // 2
                                           [self uploadError:responseBody];
                                       });
                                   } progress:^(int64_t completedBytesCount, int64_t totalBytesCount) {
                                       
                                   }];
    });
}

- (void)uploadData:(NSData *)data saveKey:(NSString *)saveKey bucket:(NSString *)bucket{
    
//    [UPYUNConfig sharedInstance].DEFAULT_BUCKET = @"yuefile";
//    [UPYUNConfig sharedInstance].DEFAULT_PASSCODE = @"3ud4dQlQSvVjWYmnXcgvWMXUJgg=";
//    //    -H "x-upyun-meta-secret: upyun520"
    
    //    [UPYUNConfig sharedInstance].DEFAULT_BUCKET = @"yueimage";
    //    [UPYUNConfig sharedInstance].DEFAULT_PASSCODE = @"akIzlq0KFj8gUp79S+3oqWDQ69Q=";
    
//    __block UpYun *uy = [[UpYun alloc] init];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
//        uy.successBlocker = ^(NSURLResponse *response, id responseData) {
//            dispatch_async(dispatch_get_main_queue(), ^{ // 2
//                NSLog(@"response body %@", saveKey);
//            });
//        };
//        uy.failBlocker = ^(NSError * error) {
//            NSString *message = error.description;
//
//            NSLog(@"error %@", error);
//        };
//        uy.progressBlocker = ^(CGFloat percent, int64_t requestDidSendBytes) {
//        };
//        
//        [uy uploadFile:data saveKey:saveKey];
//    });
}

- (NSString * )getSaveKeyWith:(NSString *)suffix {
    /**
     *	@brief	方式1 由开发者生成saveKey
     */
    return [NSString stringWithFormat:@"/%@%@.%@", [self getDateString], [self getRandomString], suffix];
    /**
     *	@brief	方式2 由服务器生成saveKey
     */
    //    return [NSString stringWithFormat:@"/{year}/{mon}/{filename}{.suffix}"];
    /**
     *	@brief	更多方式 参阅 http://docs.upyun.com/api/form_api/#_4
     */
}
\

#define kRandomLength 30
// 随机字符表
static const NSString *kRandomAlphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

- (NSString *)getRandomString {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:kRandomLength];
    for (int i = 0; i < kRandomLength; i++) {
        [randomString appendFormat: @"%C", [kRandomAlphabet characterAtIndex:arc4random_uniform((u_int32_t)[kRandomAlphabet length])]];
    }
    
    return  randomString;
}



- (NSString *)getDateString {
    NSDate *curDate = [NSDate date];//获取当前日期
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy/MM/dd"];//这里去掉 具体时间 保留日期
    NSString * curTime = [formater stringFromDate:curDate];
    curTime = [NSString stringWithFormat:@"%@/%.0f", curTime, [curDate timeIntervalSince1970]];
    return curTime;
}


- (void)clearCache {
    _maxCount       = 0;
    _completeCount  = 0;
    [_photosArray removeAllObjects];
    [UpYunBlockUpLoader clearCache];
}

@end
