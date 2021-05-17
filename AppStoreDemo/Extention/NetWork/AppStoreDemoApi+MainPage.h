//
//  AppStoreDemoApi+MainPage.h
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/13.
//

#import "AppStoreDemoApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppStoreDemoApi (MainPage)

/// 获取推荐 APP 列表
/// @param successBlock 成功数据
/// @param failureBlock 失败数据
+(void)getRecomendAppDataFromItunesCompleted:(HttpSuccessBlock)successBlock failure:(HttpFailureBlock)failureBlock;


/// 获取免费 APP 列表数据
/// @param successBlock 成功数据
/// @param failureBlock 失败数据
+(void)getTopFreeAppDataFromItunesCompleted:(HttpSuccessBlock)successBlock failure:(HttpFailureBlock)failureBlock;

/// 获取 APP 详情
/// @param successBlock 成功数据
/// @param failureBlock 失败数据
+(void)getAppDetailWithAppId:(NSString *)AppId FromItunesCompleted:(HttpSuccessBlock)successBlock failure:(HttpFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
