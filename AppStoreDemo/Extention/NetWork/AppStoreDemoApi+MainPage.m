//
//  AppStoreDemoApi+MainPage.m
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/13.
//

#import "AppStoreDemoApi+MainPage.h"

#define Server_Based_Url     @"https://itunes.apple.com/hk/"

@implementation AppStoreDemoApi (MainPage)


+(void)getRecomendAppDataFromItunesCompleted:(HttpSuccessBlock)successBlock failure:(HttpFailureBlock)failureBlock{
    [AppStoreDemoApi getRequestWithServerName:Server_Based_Url keyString:@"rss/topgrossingapplications/limit=10/json" successedBlock:successBlock failedBlock:failureBlock];
}


+(void)getTopFreeAppDataFromItunesCompleted:(HttpSuccessBlock)successBlock failure:(HttpFailureBlock)failureBlock{
    [AppStoreDemoApi getRequestWithServerName:Server_Based_Url keyString:@"rss/topfreeapplications/limit=100/json" successedBlock:successBlock failedBlock:failureBlock];
    
}

+(void)getAppDetailWithAppId:(NSString *)AppId FromItunesCompleted:(HttpSuccessBlock)successBlock failure:(HttpFailureBlock)failureBlock{
    [AppStoreDemoApi getRequestWithServerName:Server_Based_Url keyString:[NSString stringWithFormat:@"lookup?id=%@",AppId] successedBlock:successBlock failedBlock:failureBlock];
    
}



@end
