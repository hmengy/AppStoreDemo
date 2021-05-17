//
//  MainPageController.m
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/12.
//

#import "MainPageController.h"
#import <MJRefresh.h>
#import "HorizontalListAppCell.h"
#import "MainPageViewModel.h"
#import "AppListDataModel.h"
#import "AppStoreDemo-Swift.h"
#import "AppSearchBarView.h"
#import "AppSearchResultView.h"
#import <SVProgressHUD.h>

@interface MainPageController ()<UITableViewDataSource,UITableViewDelegate,AppSearchBarViewDelegate>

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataArray;
@property (nonatomic, strong) RecommendHeadBackView *headView;
@property (nonatomic, strong) AppSearchBarView      *searchView;
@property (nonatomic, strong) AppSearchResultView   *searchResultView;
@property (nonatomic, strong) MainPageViewModel     *viewModel;
@property (nonatomic, assign) NSInteger              pageNo;
@end

@implementation MainPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNo = 1;
    [self createUI];
    [self loadData];
}

-(void)createUI{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchView];
}


#pragma mark - tableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppListDataModel *model = [self.dataArray objectAtIndex:indexPath.row];
    HorizontalListAppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HorizontalListAppCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (model) {
       
        [cell updateUIWithModel:model andIndex:indexPath.row];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppListDataModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"即将进入%@详情页",model.appName]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.dataArray.count > 0) {
        return self.headView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.dataArray.count > 0) {
        return 210;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.001;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    if (row == self.dataArray.count - 2 ) {
        [self loadMoreData];
    }
}


#pragma mark - AppSearchBarView delegate
-(void)searchBarCancelButtonClicked{
    [self.searchResultView removeFromSuperview];
}

-(void)searchBarSearchButtonClick:(NSString *)searchKey{
    
    [self.viewModel searchAppDataWithSearchKey:searchKey Complete:^(NSArray * _Nonnull dataAry) {
        if (dataAry.count > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view addSubview:self.searchResultView];
                [self.view bringSubviewToFront:self.searchResultView];
                [self.searchResultView updateUIWithData:dataAry];
            });
            
        }
    }];
    
}


#pragma mark - 数据请求
- (void)loadData { // 重新加载数据
    [self.viewModel getRecomendAppDataComplete:^(NSArray * _Nonnull dataAry) {
        if (dataAry.count > 0) {
            [self.headView updateReloadCollectionViewWithDataAry:dataAry];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    
    [self.viewModel getSumTopFreeAppDataComplete:^(NSArray * _Nonnull dataAry) {
        if (dataAry.count > 0) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:dataAry];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        }else{
            NSLog(@"未请求到数据");
        }
    }];
}

-(void)loadMoreData{
    self.pageNo ++;
    if (self.pageNo > 10) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    [self.viewModel getTopFreeAppDataPage:self.pageNo Complete:^(NSArray * _Nonnull dataAry) {
        if (dataAry.count > 0) {
            [self.dataArray addObjectsFromArray:dataAry];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
            });
            
        }
    }];
}






#pragma mark - setter
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (MainPageViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[MainPageViewModel alloc]init];
    }
    return _viewModel;
}

- (RecommendHeadBackView *)headView{
    if (!_headView) {
        _headView = [[RecommendHeadBackView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    }
    return _headView;
}

- (AppSearchBarView *)searchView{
    if (!_searchView) {
        _searchView = [[AppSearchBarView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, heightNavBar)];
        _searchView.delegate = self;
    }
    return _searchView;
}

-(AppSearchResultView *)searchResultView{
    if (!_searchResultView) {
        _searchResultView = [[AppSearchResultView alloc]initWithFrame:CGRectMake(0, heightNavBar, ScreenW, ScreenH-heightNavBar)];
    }
    return _searchResultView;
}



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, heightNavBar, ScreenW, (ScreenH - heightNavBar)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [_tableView registerClass:[HorizontalListAppCell class] forCellReuseIdentifier:@"HorizontalListAppCell"];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
        }];
        
    }
    return _tableView;
}

@end
