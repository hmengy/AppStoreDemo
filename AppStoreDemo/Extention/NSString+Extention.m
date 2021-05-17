//
//  NSString+Extention.m
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/14.
//

#import "NSString+Extention.h"

@implementation NSString (Extention)

//转 json
+(NSString *)objectToJson:(id)obj{
    if (obj == nil) {
        return nil;
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:0
                                                         error:&error];
    
    if ([jsonData length] && error == nil){
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}

//字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"json解析失败 %@",error);
        error = nil;
        // 此处遇到 NSJSONSerialization 抛出异常 - “Garbage at End”，
        // 大致原因是因为 含有JSON转换无法识别的字符。这里的string是加密过的，导致解密后的数据加了一些 “操作符”，我们需要把这些操作符给去掉
        // 下面代码将 所有控制符都会被替换成空字符
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
        // 再将 string 装成 data 格式
        jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        // 将 data 装成字典
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    }
    return dic;
}

@end
