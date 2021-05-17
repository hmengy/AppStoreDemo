//
//  AppSearchBarView.m
//  AppStoreDemo
//
//  Created by hmengy on 2021/5/13.
//

#import "AppSearchBarView.h"
#import <Masonry/Masonry.h>

@interface AppSearchBarView()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, assign) BOOL isShowBackBtn;
@end


@implementation AppSearchBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self addViewFrameContrains];
    }
    return self;
}

- (CGSize )intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}

- (void)setupUI {
    [self addSubview:self.cancelBtn];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.iconImg];
    [self.bgView addSubview:self.textField];
    
}

- (void)addViewFrameContrains {
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(heightStatusBar+4);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(36);
        make.width.offset(80);
    }];
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(heightStatusBar+4);
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self.mas_right).offset(-12).priorityHigh();
        make.height.offset(36);
    }];
    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.left.equalTo(self.bgView).offset(10);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(13);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(3);
        make.right.equalTo(self.bgView.mas_right).offset(-20);
        make.top.bottom.equalTo(self.bgView);
        make.centerY.equalTo(self.iconImg);
    }];
    
    self.cancelBtn.hidden = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];

}

#pragma mark - Public

- (void)becomeOnfocus {
    [self.textField becomeFirstResponder];
}


#pragma mark - Private
- (void)cancelClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarCancelButtonClicked)]) {
        [self.delegate searchBarCancelButtonClicked];
    }
    self.textField.text = @"";
    [self.textField endEditing:YES];
    self.cancelBtn.hidden = YES;
    [self sendSubviewToBack:self.cancelBtn];
    [self bringSubviewToFront:self.cancelBtn];
}



#pragma mark - Delegate
#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.cancelBtn.hidden = NO;
    [self bringSubviewToFront:self.cancelBtn];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *userId = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self.textField endEditing:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarSearchButtonClick:)]) {
        [self.delegate searchBarSearchButtonClick:userId];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString* resultStr=[textField.text stringByReplacingCharactersInRange:range withString:string];
    if (resultStr && self.delegate && [self.delegate respondsToSelector:@selector(searchBarSearchButtonClick:)]) {
        [self.delegate searchBarSearchButtonClick:resultStr];
    }
    return YES;
}

#pragma mark - Getters

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 8;
        _bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _bgView.layer.borderWidth = 0.5f;
    }
    return _bgView;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.image = [UIImage imageNamed: @"main_search_icon"];
    }
    return _iconImg;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont boldSystemFontOfSize:12] ;
        _textField.delegate = self;
        _textField.placeholder = @" 輸入應⽤名、開發者名和應⽤描述來進⾏搜索";
        _textField.textColor = [UIColor lightGrayColor];
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.clearButtonMode = UITextFieldViewModeNever;
    }
    return _textField;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

@end
