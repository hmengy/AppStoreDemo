//
//  ApplicationDataModel+CoreDataProperties.m
//  
//
//  Created by hmengy on 2021/5/15.
//
//

#import "ApplicationDataModel+CoreDataProperties.h"

@implementation ApplicationDataModel (CoreDataProperties)

+ (NSFetchRequest<ApplicationDataModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ApplicationDataModel"];
}

@dynamic appDesc;
@dynamic appDeveloper;
@dynamic appIcon;
@dynamic appID;
@dynamic appName;
@dynamic appType;
@dynamic appScore;
@dynamic appUserCount;
@dynamic appIndex;

@end
