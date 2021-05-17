//
//  AppSearchBarView.h
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/13.
//

#import <UIKit/UIKit.h>

/**
 代理
 */
@protocol AppSearchBarViewDelegate <NSObject>

@optional

/**
 点击取消
 */
- (void)searchBarCancelButtonClicked;

- (void)searchBarSearchButtonClick:(NSString*)searchKey;


@end


@interface AppSearchBarView : UIView

/**
 代理
 */
@property (nonatomic, assign) id<AppSearchBarViewDelegate>delegate;

@end


