//
//  AppSessionManager.m
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/12.
//

#import "AppSessionManager.h"

static AFHTTPSessionManager *manager;

@implementation AppSessionManager

+(AFHTTPSessionManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript",@"text/html", nil];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 15.0f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        AFSecurityPolicy * securityPolicy = [[AFSecurityPolicy alloc]init];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        manager.securityPolicy = securityPolicy;
    });
    return manager;
}

@end
