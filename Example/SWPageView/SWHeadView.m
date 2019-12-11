//
//  SWHeadView.m
//  SWPageView_Example
//
//  Created by Lemon on 2019/12/11.
//  Copyright © 2019 LemonGui. All rights reserved.
//

#import "SWHeadView.h"

@interface SWHeadView ()
@property (nonatomic,strong) UIImageView * bgImageView;
@property (nonatomic,strong) UIButton * btn;

@end

@implementation SWHeadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.bgImageView];
        [self addSubview:self.btn];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bgImageView.frame = self.bounds;
    [self.btn sizeToFit];
    self.btn.center = CGPointMake(self.width/2, self.height - 30);
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"改变高度" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(changeH) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

-(void)changeH{
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
}

@end
