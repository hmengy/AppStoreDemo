//
//  CoreDataManagerTest.m
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/13.
//

#import "CoreDataManager.h"
#import "ApplicationDataModel+CoreDataProperties.h"
#import <objc/runtime.h>
#import <CoreData/CoreData.h>
#import "AppIconUrlModel.h"
#import "NSString+Extention.h"
@interface CoreDataManager ()
/*
 封装了应用程序中的CoreData Stack（核心数据栈堆）
 */
@property (strong, nonatomic) NSPersistentContainer *container;

@end


@implementation CoreDataManager


static CoreDataManager *coreDataManagerTest = nil;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coreDataManagerTest = [[CoreDataManager alloc] init];
    });
    return coreDataManagerTest;
}

-(void)deleteAllDataSuccess:(void (^)(void))success fail:(void (^)(NSError *))faile{
    [self.container performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
        NSFetchRequest * request = [ApplicationDataModel fetchRequest];
        //增加指定条件的数据，这里是全删
        //NSPredicate * predicate = [NSPredicate predicateWithFormat:@"name=%@", @"张三"];
        //request.predicate= predicate;
        NSError *error =nil;
        NSArray *resultArray = [context executeFetchRequest:request error:&error];
        if(error) {
            NSLog(@"查询失败");
        }
        //删除查询后的所有记录
        for(ApplicationDataModel * model in resultArray){
            //将上面的记录从数据库中删除(**从内存中删除对象)
            [context deleteObject:model];
        }
        //执行保存操作(真正的从数据库中删除)
        [context save:&error];
        if(error) {
            if (faile) {
                faile(error);
            }
        }else{
            NSLog(@"删除成功");
            if (success) {
                success();
            }
        }
    }];
}

- (void)insertNewData:(AppListDataModel *)listModel success:(void (^)(void))success fail:(void (^)(NSError *))faile{
    if (!listModel) return;
    
    [self.container performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
        [context performBlockAndWait:^{
            ApplicationDataModel *coreDataModel = [NSEntityDescription insertNewObjectForEntityForName:@"ApplicationDataModel" inManagedObjectContext:context];
            coreDataModel.appName = listModel.appName;
            coreDataModel.appType = listModel.appType;
            coreDataModel.appID   = listModel.appID;
            coreDataModel.appDesc = listModel.appDesc;
            coreDataModel.appIndex = listModel.appIndex;
            
            AppIconUrlModel *iconModel = listModel.imageAry.lastObject;
            NSString *imgUrl = @"";
            if (listModel.imageAry.count > 0) {
                imgUrl = iconModel.label;
            }
            coreDataModel.appIcon = imgUrl;
            NSError *error =nil;
            [context save:&error];
            if (error) {
                NSLog(@"插入失败: %@", error.userInfo);
                if (faile) {
                    faile(error);
                }
            }else{
//                NSLog(@"插入成功");
                if (success) {
                    success();
                }
            }
        }];
    }];
}

- (void)searchDataWithKeyWords:(NSString *)selectKeys success:(void (^)(NSArray *))success fail:(void (^)(NSError *))faile{
    
    [self.container performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
        NSFetchRequest *request = [ApplicationDataModel fetchRequest];
        if (selectKeys && selectKeys.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appName CONTAINS %@ OR appDeveloper=%@ OR appDesc=%@ ", selectKeys,selectKeys,selectKeys];
            request.predicate= predicate;
        }
        //添加排序的条件
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"appIndex" ascending:YES];
        request.sortDescriptors=@[sort];

        NSError *error =nil;
        NSArray *resultArray = [context executeFetchRequest:request error:&error];
        if (error) {
            NSLog(@"查询失败: %@", error.userInfo);
            if (faile) {
                faile(error);
            }
        }else{
            NSLog(@"查询成功");
            if (success) {
                success(resultArray);
            }
//            for(ApplicationDataModel *model in resultArray) {
//                NSLog(@"名字:%@; appid:%@", model.appName,model.appID);
//            }
        }
    }];
}

-(void)updateAppDataByAppID:(NSString *)appID scoreStar:(NSString *)starStr useCount:(NSString *)useCount{
    
    [self.container performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
        NSFetchRequest *request = [ApplicationDataModel fetchRequest];
        if (appID && appID.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appID=%@", appID];
            request.predicate= predicate;
        }
        NSError *error =nil;
        NSArray *resultArray = [context executeFetchRequest:request error:&error];
        if (error) {
            NSLog(@"查询失败: %@", error.userInfo);
            
        }else{
//            NSLog(@"查询成功");
            for(ApplicationDataModel *model in resultArray) {
//                NSLog(@"名字:%@; appid:%@", model.appName,model.appID);
                model.appScore = starStr;
                model.appUserCount = useCount;
            }
            [context save:&error];
            if (error) {
                NSLog(@"app 评分等更新失败");
            }else{
//                NSLog(@"app 评分等更新成功");
            }
            
        }
    }];
    
}



-(void)saveCacheWithKey:(NSString*)key cacheDictionary:(NSDictionary*)dicInfo {
    if (dicInfo && [dicInfo isKindOfClass:[NSDictionary class]]) {
        NSString *infoJson = [NSString objectToJson:dicInfo];
        if (infoJson && infoJson.length > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:infoJson forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
}

- (NSDictionary*)readUserCacheWithKey:(NSString*)key {
    NSDictionary *userDic = nil;
    if (key.length > 0) {
        NSString *jsonString = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        if (jsonString.length > 0) {
            userDic = [NSString dictionaryWithJsonString:jsonString];
        }
    }
    return userDic;
}


//懒加载
- (NSPersistentContainer *)container {
    if(!_container) {
        _container = [[NSPersistentContainer alloc] initWithName:@"AppListData"];
        //NewCodeDataModel.xcdatamodeld
//        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AppListData" withExtension:@"momd"];
//        NSLog(@"modelURL = %@",modelURL);
        [_container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull storeDescription, NSError * _Nullable error) {
            
        }];
    }
    return _container;
    
}


@end
