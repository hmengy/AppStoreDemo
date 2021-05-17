//
//  AppStoreDemoApi.h
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/12.
//

#import <Foundation/Foundation.h>

typedef void (^HttpSuccessBlock)(id responseInfo);
typedef void (^HttpFailureBlock)(id responseInfo);

@interface AppStoreDemoApi : NSObject

+(void)getRequestWithServerName:(NSString *)serverName keyString:(NSString*)keyStr successedBlock:(HttpSuccessBlock)successBlock failedBlock:(HttpFailureBlock)failedBlock;

+(void)postRequestWithParamDict:(NSMutableDictionary *)tempParams funName:(NSString *)funName successedBlock:(HttpSuccessBlock)successBlock failedBlock:(HttpFailureBlock)failedBlock;

@end

