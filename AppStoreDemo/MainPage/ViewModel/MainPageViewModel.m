//
//  MainPageViewModel.m
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/13.
//

#import "MainPageViewModel.h"
#import "AppStoreDemoApi+MainPage.h"
#import <MJExtension.h>
#import "CoreDataManager.h"
#import "AppListDataModel.h"
#import "ApplicationDataModel+CoreDataProperties.h"

@interface MainPageViewModel()

@property (nonatomic, strong) NSMutableArray    *listArray;
@end

@implementation MainPageViewModel


-(void)getRecomendAppDataComplete:(nullable void(^)(NSArray *dataAry))complete{
    
    NSDictionary *cacheDic = [[CoreDataManager sharedInstance] readUserCacheWithKey:@"recommend_App"];
    if (cacheDic && [cacheDic.allKeys containsObject:@"feed"]) {
        
        NSArray *resultAry = [AppListDataModel mj_objectArrayWithKeyValuesArray:cacheDic[@"feed"][@"entry"]];
       NSMutableArray *cacheAry = [NSMutableArray arrayWithArray:resultAry];
        complete(cacheAry);
    }
    
    
    [AppStoreDemoApi getRecomendAppDataFromItunesCompleted:^(id responseInfo) {
        NSDictionary *resultDic = responseInfo;
        
        if ([resultDic.allKeys containsObject:@"feed"]) {
            NSMutableArray *dataAry = [NSMutableArray array];
            
            NSArray *resultAry = [AppListDataModel mj_objectArrayWithKeyValuesArray:resultDic[@"feed"][@"entry"]];
           dataAry = [NSMutableArray arrayWithArray:resultAry];
            complete(dataAry);
            
            [[CoreDataManager sharedInstance] saveCacheWithKey:@"recommend_App" cacheDictionary:resultDic];
        }
        complete(nil);
        
    } failure:^(id responseInfo) {
        complete(nil);
        
    }];
}

-(void)getSumTopFreeAppDataComplete:(nullable void(^)(NSArray *dataAry))complete{
    
    [self getTopFreeAppDataPage:1 Complete:^(NSArray * _Nonnull dataAry) {
        if (dataAry.count > 0) {
            complete(dataAry);
        }
    }];
    
    
    [AppStoreDemoApi getTopFreeAppDataFromItunesCompleted:^(id responseInfo) {
        NSDictionary *resultDic = responseInfo;
        if ([resultDic.allKeys containsObject:@"feed"]) {
            NSMutableArray *dataAry = [NSMutableArray array];
            
            NSArray *resultAry = [AppListDataModel mj_objectArrayWithKeyValuesArray:resultDic[@"feed"][@"entry"]];
            if (resultAry.count >= 10) {
                dataAry = [NSMutableArray arrayWithArray: [resultAry subarrayWithRange:NSMakeRange(0, 10)]];
            }else{
                dataAry = [NSMutableArray arrayWithArray:resultAry];
            }
            [[CoreDataManager sharedInstance] deleteAllDataSuccess:^{
                [self keepDataToCoreDataWithArray:resultAry];
            } fail:^(NSError * error) {
                
            }];
            complete(dataAry);
        }
        complete(nil);
        
    } failure:^(id responseInfo) {
        complete(nil);
        
    }];
}


-(void)getTopFreeAppDataPage:(NSInteger )pageNO Complete:(nullable void(^)(NSArray *dataAry))complete{
    NSMutableArray *resultAry = [NSMutableArray array];
    [[CoreDataManager sharedInstance] searchDataWithKeyWords:@"" success:^(NSArray * searchResultAry) {
        if (searchResultAry.count >= pageNO*10) {
            NSArray *pageAry = [searchResultAry subarrayWithRange:NSMakeRange((pageNO-1)*10, 10)];
            for (int i = 0; i < pageAry.count; i++) {
                ApplicationDataModel *coreModel = pageAry[i];
                AppListDataModel *newModel = AppListDataModel.new;
                newModel.appName = coreModel.appName;
                newModel.appType = coreModel.appType;
                newModel.appID   = coreModel.appID;
                newModel.appDesc = coreModel.appDesc;
                newModel.appIcon = coreModel.appIcon;
                [resultAry addObject:newModel];
            }
        }
        if (complete) {
            complete(resultAry);
        }
    } fail:^(NSError * error) {
        if (error) {
            if (complete) {
                complete(resultAry);
            }
        }
    }];
}

-(void)keepDataToCoreDataWithArray:(NSArray *)dataAry{
    for (int i = 0; i<dataAry.count; i++) {
        AppListDataModel *dataModel = dataAry[i];
        dataModel.appIndex = i;
        [[CoreDataManager sharedInstance]insertNewData:dataModel success:^{
            
        } fail:^(NSError * error) {
            
        }];
    }
}

-(void)getApplicationDetailWithAppId:(NSString *)appID Complete:(nullable void(^)(NSString *scrole,NSString * ratingCount))complete{
    [AppStoreDemoApi getAppDetailWithAppId:appID FromItunesCompleted:^(id responseInfo) {
        NSDictionary *resultDic = responseInfo;
        if ([resultDic.allKeys containsObject:@"results"]) {
            NSArray *resultAry = resultDic[@"results"];
            if (resultAry.count > 0) {
                NSDictionary *appDetail = resultAry.firstObject;
                NSString *scroleValue = [appDetail[@"averageUserRating"] stringValue];
                NSString *ratingCountValue = [appDetail[@"userRatingCountForCurrentVersion"] stringValue];
                if (complete) {
                    complete(scroleValue,ratingCountValue);
                }
            }else{
                if (complete) {
                    complete(nil,nil);
                }
            }
        }
    
    } failure:^(id responseInfo) {
        
    }];
}

-(void)searchAppDataWithSearchKey:(NSString *)searchKey Complete:(nullable void(^)(NSArray *dataAry))complete{
    
    NSMutableArray *resultAry = [NSMutableArray array];
    [[CoreDataManager sharedInstance] searchDataWithKeyWords:searchKey success:^(NSArray * searchResultAry) {
        for (int i = 0; i < searchResultAry.count; i++) {
            ApplicationDataModel *coreModel = searchResultAry[i];
            AppListDataModel *newModel = AppListDataModel.new;
            newModel.appName = coreModel.appName;
            newModel.appType = coreModel.appType;
            newModel.appID   = coreModel.appID;
            newModel.appDesc = coreModel.appDesc;
            newModel.appIcon = coreModel.appIcon;
            [resultAry addObject:newModel];
        }
        if (complete) {
            complete(resultAry);
        }
        
    } fail:^(NSError * error) {
        if (error) {
            if (complete) {
                complete(resultAry);
            }
        }
        
    }];
}

@end
