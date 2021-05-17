//
//  AppListDataModel.m
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/13.
//

#import "AppListDataModel.h"
#import <MJExtension.h>
#import "AppIconUrlModel.h"
@implementation AppListDataModel



+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"appName"      : @"im:name.label",
             @"appType"      : @"category.attributes.label",
             @"appID"        : @"id.attributes.im:id",
             @"imageAry"     : @"im:image",
             @"appDesc"      : @"summary.label",
             @"appDeveloper" : @"rights.label"
             };
}

- (void)setImageAry:(NSArray *)imageAry{
    _imageAry = [AppIconUrlModel mj_objectArrayWithKeyValuesArray:imageAry];
}

@end
