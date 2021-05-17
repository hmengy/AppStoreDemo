//
//  AppListDataModel.h
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppListDataModel : NSObject

@property (nonatomic, copy)  NSString *appIcon;

@property (nonatomic, copy)  NSString *appID;

@property (nonatomic, copy)  NSString *appName;

@property (nonatomic, copy)  NSString *appType;

@property (nonatomic, copy)  NSString *appDesc;

@property (nonatomic, copy)  NSString *appDeveloper;

@property (nonatomic, copy)  NSString *appScore;

@property (nonatomic, copy)  NSString *appUserCount;

@property (nonatomic, assign)NSInteger appIndex;

@property (nonatomic, strong) NSArray  * imageAry;

@end

NS_ASSUME_NONNULL_END
