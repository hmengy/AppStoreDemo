//
//  MainPageViewModel.h
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainPageViewModel : NSObject

/// 根据推荐 APP 列表
/// @param complete 结果回调
-(void)getRecomendAppDataComplete:(nullable void(^)(NSArray *dataAry))complete;
/// 根据免费 APP 列表
/// @param complete 结果回调
-(void)getSumTopFreeAppDataComplete:(nullable void(^)(NSArray *dataAry))complete;

/// 根据免费磅
/// @param pageNO 页码
/// @param complete 结果回调
-(void)getTopFreeAppDataPage:(NSInteger )pageNO Complete:(nullable void(^)(NSArray *dataAry))complete;

-(void)searchAppDataWithSearchKey:(NSString *)searchKey Complete:(nullable void(^)(NSArray *dataAry))complete;

-(void)getApplicationDetailWithAppId:(NSString *)appID Complete:(nullable void(^)(NSString *scrole,NSString * ratingCount))complete;
@end

NS_ASSUME_NONNULL_END
