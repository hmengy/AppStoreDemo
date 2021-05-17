//
//  AppStoreDemoApi.m
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/12.
//

#import "AppStoreDemoApi.h"
#import "AppSessionManager.h"
#import <AFNetworking.h>

@implementation AppStoreDemoApi


+(void)getRequestWithServerName:(NSString *)serverName keyString:(NSString*)keyStr successedBlock:(HttpSuccessBlock)successBlock failedBlock:(HttpFailureBlock)failedBlock{
    __block void (^tmpSuccessBlock)(id) = successBlock;
    __block void (^tmpFailedBlock)(id) = failedBlock;
    NSMutableDictionary *tempParams  = [NSMutableDictionary dictionary];
    AFHTTPSessionManager *manager = [AppSessionManager sharedManager];
    NSString * resultFunName = [NSString stringWithFormat:@"%@",serverName];
    if (keyStr != nil) {
        resultFunName = [NSString stringWithFormat:@"%@%@",serverName,keyStr];
    }
    NSLog(@"resultFunName = %@",resultFunName);
    [manager GET:resultFunName parameters:tempParams headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = responseObject;
//        NSLog(@"responseObject = %@",json);
        tmpSuccessBlock(json);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        tmpFailedBlock(error);
        NSLog(@"error = %@",error);
    }];
}


+(void)postRequestWithParamDict:(NSMutableDictionary *)tempParams funName:(NSString *)funName successedBlock:(HttpSuccessBlock)successBlock failedBlock:(HttpFailureBlock)failedBlock{
    __block void (^tmpSuccessBlock)(id) = successBlock;
    __block void (^tmpFailedBlock)(id) = failedBlock;
    if (tempParams == nil){
        tempParams  = [NSMutableDictionary dictionary];
    }
    AFHTTPSessionManager *manager = [AppSessionManager sharedManager];
    [manager POST:funName parameters:tempParams headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = responseObject;

        tmpSuccessBlock(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        tmpFailedBlock(error);
    }];
}

@end
