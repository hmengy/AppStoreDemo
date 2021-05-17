//
//  NSString+Extention.h
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extention)

//转 json
+(NSString *)objectToJson:(id)obj;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
