//
//  HorizontalListAppCell.m
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/12.
//

#import "HorizontalListAppCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage.h>
#import "AppIconUrlModel.h"
#import "JZLStarView.h"
#import "MainPageViewModel.h"
#import "CoreDataManager.h"

@interface HorizontalListAppCell()

@property (nonatomic,strong) UIView *backView;
/*排名*/
@property (nonatomic,strong) UILabel *sortNumLab;
/* icon*/
@property (nonatomic,strong) UIImageView *iconImg;
/*app 名称*/
@property (nonatomic,strong) UILabel *appNameLab;
/*app 类型*/
@property (nonatomic,strong) UILabel *appTypeLab;
/*星级评分*/
@property(nonatomic,strong)JZLStarView *starView;
/*评分数*/
@property (nonatomic,strong) UILabel *rankingLab;
/*线条*/
@property (nonatomic,strong) UILabel *lineLab;

@property (nonatomic,strong) AppListDataModel *model;

@end

@implementation HorizontalListAppCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)updateUIWithModel:(AppListDataModel *)model andIndex:(NSInteger )indexSort{
    _model = model;
    self.sortNumLab.text = [NSString stringWithFormat:@"%ld",indexSort+1];
    AppIconUrlModel *iconModel = _model.imageAry.lastObject;
    NSString *imgUrl = _model.appIcon;
    if (_model.imageAry.count > 0) {
        imgUrl = iconModel.label;
    }
    if (indexSort % 2 == 0) {
        self.iconImg.layer.cornerRadius = 8;
    }else{
        self.iconImg.layer.cornerRadius = 44;
    }
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    self.appNameLab.text = _model.appName;
    self.appTypeLab.text = _model.appType;
    self.starView.hidden = YES;
    self.rankingLab.hidden = YES;
    
    if ([self.model.appScore floatValue] > 0) {
        self.starView.hidden = NO;
        self.rankingLab.hidden = NO;
        self.starView.currentScore = [self.model.appScore floatValue];
        if ([self.model.appUserCount integerValue] > 100000) {
            self.rankingLab.text = [NSString stringWithFormat:@"(%ld万)",[self.model.appUserCount  integerValue]/10000];
        }else{
            self.rankingLab.text = [NSString stringWithFormat:@"(%ld)",[self.model.appUserCount  integerValue]];
        }
    }else{
        [self getScoreData];
    }
    
}


-(void)getScoreData{
    [[MainPageViewModel alloc] getApplicationDetailWithAppId:self.model.appID Complete:^(NSString * _Nonnull scrole, NSString * _Nonnull ratingCount) {
        if (scrole && ratingCount) {
            self.starView.hidden = NO;
            self.rankingLab.hidden = NO;
            
            self.model.appScore = scrole;
            self.starView.currentScore = [scrole floatValue];
            self.model.appUserCount = ratingCount;
            if ([ratingCount integerValue] > 100000) {
                self.rankingLab.text = [NSString stringWithFormat:@"(%ld万)",[ratingCount integerValue]/10000];
            }else{
                self.rankingLab.text = [NSString stringWithFormat:@"(%ld)",[ratingCount integerValue]];
            }
            
            
            [[CoreDataManager sharedInstance] updateAppDataByAppID:self.model.appID scoreStar:scrole useCount:ratingCount];
        }
    }];
}



- (void)createUI{
//    self.backgroundColor = [UIColor clearColor];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.backView addSubview:self.sortNumLab];
    [self.sortNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView.mas_centerY);
        make.left.equalTo(self.backView.mas_left).offset(16);
        make.width.offset(40);
    }];
    [self.backView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sortNumLab.mas_right).offset(8);
        make.centerY.equalTo(self.backView.mas_centerY);
        make.width.height.offset(88);
    }];
    
    [self.backView addSubview:self.appNameLab];
    [self.appNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(8);
        make.top.equalTo(self.iconImg.mas_top).offset(2);
        make.right.equalTo(self.backView.mas_right).offset(-8);
    }];
    
    [self.backView addSubview:self.appTypeLab];
    [self.appTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.appNameLab);
        make.centerY.equalTo(self.iconImg.mas_centerY);
    }];
    
    
    [self.backView addSubview:self.starView];
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.appNameLab);
        make.bottom.equalTo(self.iconImg.mas_bottom);
        make.height.offset(16);
        make.width.offset(80);
    }];
        
    [self.backView addSubview:self.rankingLab];
    [self.rankingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.starView.mas_right).offset(6);
        make.centerY.equalTo(self.starView.mas_centerY);
    }];
    
    [self.backView addSubview:self.lineLab];
    [self.lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.backView);
        make.left.equalTo(self.backView.mas_left).offset(32);
        make.height.offset(0.5);
    }];
    
}


#pragma mark - Getters

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.image = [UIImage imageNamed:@"default_user_head"];
        _iconImg.clipsToBounds = YES;
        _iconImg.layer.cornerRadius = 8;
    }
    return _iconImg;
}

- (UILabel *)sortNumLab {
    if (!_sortNumLab) {
        _sortNumLab = [[UILabel alloc] init];
        _sortNumLab.textColor = [UIColor blackColor];
        _sortNumLab.font = [UIFont boldSystemFontOfSize:20];
        _sortNumLab.textAlignment = NSTextAlignmentCenter;
    }
    return _sortNumLab;
}

- (UILabel *)appNameLab {
    if (!_appNameLab) {
        _appNameLab = [[UILabel alloc] init];
        _appNameLab.textColor = [UIColor blackColor];
        _appNameLab.font = [UIFont boldSystemFontOfSize:16];
    }
    return _appNameLab;
}

- (UILabel *)appTypeLab {
    if (!_appTypeLab) {
        _appTypeLab = [[UILabel alloc] init];
        _appTypeLab.textColor = [UIColor darkGrayColor];
        _appTypeLab.font =  [UIFont systemFontOfSize:14];
    }
    return _appTypeLab;
}

-(JZLStarView *)starView{
    if (!_starView) {
        _starView = [[JZLStarView alloc]initWithFrame:CGRectMake(130, 12, 80, 16) starCount:5 starStyle:(IncompleteStar) isAllowScroe:NO];
        _starView.hidden = YES;
    }
    return _starView;
}


- (UILabel *)rankingLab {
    if (!_rankingLab) {
        _rankingLab = [[UILabel alloc] init];
        _rankingLab.textColor = [UIColor darkGrayColor];
        _rankingLab.font = [UIFont systemFontOfSize:14];
        _rankingLab.text = @"";
        _rankingLab.hidden = YES;
    }
    return _rankingLab;
}

- (UILabel *)lineLab {
    if (!_lineLab) {
        _lineLab = [[UILabel alloc] init];
        _lineLab.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLab;
}


@end
