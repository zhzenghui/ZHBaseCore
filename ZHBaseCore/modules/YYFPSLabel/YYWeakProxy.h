//
//  YYWeakProxy.h
//  Cosplay
//
//  Created by zeng on 2020/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYWeakProxy : NSProxy
/**
 The proxy target.
 */
@property (nonatomic, weak, readonly) id target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
- (instancetype)initWithTarget:(id)target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
+ (instancetype)proxyWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
