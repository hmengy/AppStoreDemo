//
//  AppSessionManager.h
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/12.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
NS_ASSUME_NONNULL_BEGIN

@interface AppSessionManager : NSObject

+(AFHTTPSessionManager *)sharedManager;

@end

NS_ASSUME_NONNULL_END
