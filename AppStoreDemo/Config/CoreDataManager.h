//
//  CoreDataManagerTest.h
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/13.
//

#import <Foundation/Foundation.h>
#import "AppListDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject
/**
 单例
 */
+ (instancetype)sharedInstance;

- (void)deleteAllDataSuccess:(void (^)(void))success fail:(void (^)(NSError *))faile;

- (void)insertNewData:(AppListDataModel *)listModel success:(void (^)(void))success fail:(void (^)(NSError *))faile;

- (void)searchDataWithKeyWords:(NSString *)selectKays success:(void (^)(NSArray *))success fail:(void (^)(NSError *))faile;
-(void)updateAppDataByAppID:(NSString *)appID scoreStar:(NSString *)starStr useCount:(NSString *)useCount;

//简单数据缓存
-(void)saveCacheWithKey:(NSString*)key cacheDictionary:(NSDictionary*)dicInfo;

- (NSDictionary*)readUserCacheWithKey:(NSString*)key ;

@end

NS_ASSUME_NONNULL_END
