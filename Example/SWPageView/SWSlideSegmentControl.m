//
//  SWSlideSegmentControl.m
//
//  Created by Lemon on 2019/3/18.
//

#import "SWSlideSegmentControl.h"

@interface SWSlideSegmentControl ()
@property (nonatomic,strong) UIView * baseView;
@property (nonatomic,strong) UIView * slidBottomLineView;
@property (nonatomic,strong) UIView * slidBackView;//用于加阴影
@property (nonatomic,strong) UIView * slidView;
@property (nonatomic,strong) UIView * slidWrapView;
@property (nonatomic,strong) UIPanGestureRecognizer * panGesture;
@property (nonatomic,strong) NSMutableArray * bottomBtnArray;
@property (nonatomic,strong) NSMutableArray * topBtnArray;
@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation SWSlideSegmentControl

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initContent];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initContent];
    }
    return self;
}

-(void)initContent{
    _baseView = [[UIView alloc] init];
    [self addSubview:_baseView];
    
    _slidBackView = [[UIView alloc] init];
    [self.baseView addSubview:_slidBackView];
    
    [self.baseView addSubview:self.slidView];
    
    _slidBottomLineView = [[UIView alloc] init];
    [self addSubview:_slidBottomLineView];
    
    self.normalbackColor = [UIColor whiteColor];
    self.selectBackColor = [UIColor whiteColor];
    self.normalTitleColor = [UIColor colorWithRed:0.16f green:0.16f blue:0.16f alpha:1.00f];
    self.selectTitleColor = [UIColor colorWithRed:0.92f green:0.34f blue:0.03f alpha:1.00f];
    self.slidBottomLineColor = [UIColor colorWithRed:0.92f green:0.34f blue:0.03f alpha:1.00f];
    self.slidBottomLineHeight = 3.0f;
    self.slidBottomLineWidth = 20.0f;
    self.titleFontSize = 13.0f;
    self.durationTime = 0.2f;
    self.bottomBtnArray = @[].mutableCopy;
    self.topBtnArray = @[].mutableCopy;
    self.slidBlockEnable = YES;
    self.showSlidBottomLine = NO;
    self.currentIndex = 0;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.baseView.frame = CGRectMake(_slidMargin, _slidMargin, self.frame.size.width - 2 * _slidMargin, self.frame.size.height - 2 * _slidMargin);
    CGFloat width = 0;
    if (self.bottomBtnArray.count > 0) {
        width = self.baseView.frame.size.width/self.bottomBtnArray.count;
    }
    [self.bottomBtnArray enumerateObjectsUsingBlock:^(UIButton *  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.frame = CGRectMake(idx * width, 0, width, self.baseView.frame.size.height);
    }];
    UIButton * btn = (UIButton *)self.bottomBtnArray[self.currentIndex];
    self.slidBottomLineView.frame = CGRectMake(0, self.frame.size.height - _slidBottomLineHeight - _slidBottomLinPadding, _slidBottomLineWidth, _slidBottomLineHeight);
    self.slidBottomLineView.center = CGPointMake(btn.center.x + self.slidMargin + (btn.titleLabel.center.x - btn.frame.size.width/2), self.slidBottomLineView.center.y) ;
    self.slidBottomLineView.layer.cornerRadius = _slidBottomLineHeight/2;
    self.slidView.frame = CGRectMake(self.currentIndex * width, 0, width, self.baseView.frame.size.height);
    self.slidBackView.frame = self.slidView.frame;
    self.slidWrapView.frame = CGRectMake(-self.currentIndex * width, 0, self.baseView.frame.size.width, self.baseView.frame.size.height);
    [self.topBtnArray enumerateObjectsUsingBlock:^(UIButton *  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.frame = CGRectMake(idx * width, 0, width, self.baseView.frame.size.height);
    }];
    
    self.slidBottomLineView.hidden = !self.showSlidBottomLine;
}

#pragma mark - Actions

-(void)btnClick:(UIButton *)btn{
    
    if (self.switchActionMode) {
        if (self.currentIndex == btn.tag) {
            UIButton * reverseBtn = self.topBtnArray[!btn.tag];
            [self btnClick:reverseBtn];
            return;
        }
    }
    
    CGFloat width = 0;
    if (self.bottomBtnArray.count > 0) {
        width = self.baseView.frame.size.width/self.bottomBtnArray.count;
    }
    [UIView animateWithDuration:_durationTime animations:^{
        CGRect slidFrame = self.slidView.frame;
        slidFrame.origin.x =  btn.tag * width;
        self.slidView.frame = slidFrame;
        CGRect slidBackFrame = self.slidBackView.frame;
        slidBackFrame.origin.x =  self.slidView.frame.origin.x;
        self.slidBackView.frame = slidBackFrame;
        CGRect slidWrapFrame = self.slidWrapView.frame;
        slidWrapFrame.origin.x =  - btn.tag * width;
        self.slidWrapView.frame = slidWrapFrame;
        self.slidBottomLineView.center = CGPointMake(btn.center.x + self.slidMargin + (btn.titleLabel.center.x - btn.frame.size.width/2), self.slidBottomLineView.center.y);
    } completion:^(BOOL finished) {
        if (self.currentIndex!=btn.tag) {
            if (self.selectedBlock) {
                self.selectedBlock(btn.tag);
            }
        }
        self.currentIndex = btn.tag;
    }];
}

-(void)pan:(UIPanGestureRecognizer *)pan{
    if (!self.slidBlockEnable) {
        return;
    }
    CGFloat width = self.baseView.width/self.titleArray.count;
    CGFloat maxX = width * (self.titleArray.count - 1);
    CGFloat minX = 0;
    
    CGPoint moviePoint = [pan translationInView:pan.view];
    self.slidView.x += moviePoint.x ;
    self.slidWrapView.x += - moviePoint.x ;
    if (self.slidView.x >= maxX) {
        self.slidView.x = maxX;
        self.slidWrapView.x = -maxX;
    }else if (self.slidView.x <= minX){
        self.slidView.x = minX;
        self.slidWrapView.x = -minX;
    }
    self.slidBottomLineView.centerX = self.slidView.centerX + self.slidMargin;
    self.slidBackView.x = self.slidView.x;
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        NSInteger index = (_slidView.x + width/2)/width;
        [UIView animateWithDuration:0.05 animations:^{
            self.slidView.x = width * index;
            self.slidWrapView.x = - width * index;
            self.slidBottomLineView.centerX = self.slidView.centerX + self.slidMargin;
            self.slidBackView.x = self.slidView.x;
        } completion:^(BOOL finished) {
            if (self.currentIndex!=index) {
                if (self.selectedBlock) {
                    self.selectedBlock(index);
                }
            }
            self.currentIndex = index;
        }];
    }
    
     [pan setTranslation:CGPointZero inView:pan.view];
}

#pragma mark- Setter/Getter
-(UIView *)slidView{
    if (!_slidView) {
        _slidView = [[UIView alloc] init];
        _slidView.clipsToBounds = YES;
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [_slidView addGestureRecognizer:_panGesture];
        _slidWrapView = [[UIView alloc] init];
        _slidWrapView.backgroundColor = [UIColor clearColor];
        [_slidView addSubview:_slidWrapView];
    }
    return _slidView;
}

-(void)setSlidBlockEnable:(BOOL)slidBlockEnable{
    _slidBlockEnable = slidBlockEnable;
    if (!slidBlockEnable) {
        [_slidView removeGestureRecognizer:_panGesture];
    }
}

-(void)setSelectedIndex:(NSInteger)index{
    if (self.bottomBtnArray.count > 0 && index < self.bottomBtnArray.count) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
        UIButton * btn = (UIButton *)self.bottomBtnArray[index];
        CGFloat width = (self.baseView.width)/self.bottomBtnArray.count;
        self.slidView.x = btn.tag * width;
        self.slidBackView.x = self.slidView.x;
        self.slidWrapView.x = - btn.tag * width;
        self.slidBottomLineView.centerX = btn.centerX + self.slidMargin + (btn.titleLabel.centerX - btn.width/2);
        self.currentIndex = btn.tag;
    }
}

-(void)clickIndex:(NSInteger)index{
    UIButton * btn = [self getBtnWithIndex:index];
    if (btn) {
        [self btnClick:btn];
    }
}

-(void)setContentEdgeInsets:(UIEdgeInsets)insets index:(NSInteger)index{
    if (self.bottomBtnArray.count > 0 && index < self.bottomBtnArray.count) {
        UIButton * bottomBtn = (UIButton *)self.bottomBtnArray[index];
        UIButton * topBtn = (UIButton *)self.topBtnArray[index];
        [bottomBtn setContentEdgeInsets:insets];
        [topBtn setContentEdgeInsets:insets];
    }
}

-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [self.bottomBtnArray removeAllObjects];
    [self.topBtnArray removeAllObjects];
    
    [titleArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * bottomBtn = [self creatBtnWithTitle:title titleColor:self.normalTitleColor index:idx];
        [self.bottomBtnArray addObject:bottomBtn];
        [self.baseView insertSubview:bottomBtn belowSubview:self.slidBackView];
        
        UIButton * topBtn = [self creatBtnWithTitle:title titleColor:self.selectTitleColor index:idx];
        [self.topBtnArray addObject:topBtn];
        [self.slidWrapView addSubview:topBtn];
    }];
    
}

-(UIButton *)getBtnWithIndex:(NSInteger)index{
    if (index < self.bottomBtnArray.count) {
        return self.bottomBtnArray[index];
    }
    return nil;
}

-(void)setSlidCornerRadius:(CGFloat)slidCornerRadius{
    _slidCornerRadius = slidCornerRadius;
    self.slidView.layer.cornerRadius = slidCornerRadius;
    self.slidBackView.layer.cornerRadius = slidCornerRadius;
}

-(void)setSlidShowColor:(UIColor *)slidShowColor{
    _slidShowColor = slidShowColor;
    self.slidBackView.layer.shadowColor = slidShowColor.CGColor;
    self.slidBackView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.slidBackView.layer.shadowRadius = 4;
    self.slidBackView.layer.shadowOpacity = 1;
}

#pragma mark- Private Method
-(UIButton *)creatBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor index:(NSInteger)index{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = index;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:self.titleFontSize];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
