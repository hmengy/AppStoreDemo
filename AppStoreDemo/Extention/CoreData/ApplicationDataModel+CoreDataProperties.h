//
//  ApplicationDataModel+CoreDataProperties.h
//  
//
//  Created by hmengy on 2021/5/15.
//
//

#import "ApplicationDataModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ApplicationDataModel (CoreDataProperties)

+ (NSFetchRequest<ApplicationDataModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *appDesc;
@property (nullable, nonatomic, copy) NSString *appDeveloper;
@property (nullable, nonatomic, copy) NSString *appIcon;
@property (nullable, nonatomic, copy) NSString *appID;
@property (nullable, nonatomic, copy) NSString *appName;
@property (nullable, nonatomic, copy) NSString *appType;
@property (nullable, nonatomic, copy) NSString *appScore;
@property (nonatomic) int16_t appIndex;
@property (nullable, nonatomic, copy) NSString *appUserCount;

@end

NS_ASSUME_NONNULL_END
