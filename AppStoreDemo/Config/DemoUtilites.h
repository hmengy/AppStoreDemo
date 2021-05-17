//
//  DemoUtilites.h
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/12.
//

#ifndef DemoUtilites_h
#define DemoUtilites_h


/********************************* 常用屏宽/高等固定值 ***********************************/
#pragma mark - 常用屏宽/高等固定值
/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width
/** 屏幕尺寸比例 */
#define ScreenWTMP [UIScreen mainScreen].bounds.size.width/375
#define ScreenHTMP [UIScreen mainScreen].bounds.size.height/667

#define heightNavBar 88
#define heightStatusBar 44
// 判断是否是刘海屏 iPhone X iPhoneXS iPhoneXS Max iPhoneXR

#define Is_iPhoneX   \
({\
    BOOL is_PhoneX = NO;\
    if (@available(iOS 11.0, *)) {\
        is_PhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
    }\
    (is_PhoneX);\
})


#endif /* DemoUtilites_h */
