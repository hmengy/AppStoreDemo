//
//  AppSearchResultView.m
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/14.
//

#import "AppSearchResultView.h"
#import "AppListDataModel.h"
#import "HorizontalListAppCell.h"
#import <SVProgressHUD.h>
@interface AppSearchResultView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataArray;

@end


@implementation AppSearchResultView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self addViewFrameContrains];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.tableView];
}

-(void)addViewFrameContrains{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AppListDataModel *model = [self.dataArray objectAtIndex:indexPath.row];
    HorizontalListAppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HorizontalListAppCell" forIndexPath:indexPath];

    if (model) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateUIWithModel:model andIndex:indexPath.row];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppListDataModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"即将进入%@详情页",model.appName]];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}

#pragma mark - 数据请求
-(void)updateUIWithData:(NSArray *)dataAry{
    self.dataArray = [NSMutableArray arrayWithArray:dataAry];
    [self.tableView reloadData];
}



#pragma mark - setter
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, (ScreenH - heightNavBar)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [_tableView registerClass:[HorizontalListAppCell class] forCellReuseIdentifier:@"HorizontalListAppCell"];
    }
    return _tableView;
}




@end
