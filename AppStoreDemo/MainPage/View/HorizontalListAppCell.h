//
//  HorizontalListAppCell.h
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/12.
//

#import <UIKit/UIKit.h>
#import "AppListDataModel.h"

@interface HorizontalListAppCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

-(void)updateUIWithModel:(AppListDataModel *)model andIndex:(NSInteger )indexSort;
@end

