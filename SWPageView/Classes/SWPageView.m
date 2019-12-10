//
//  SWPageView.m
//  SBBarModule
//
//  Created by Lemon on 2019/12/9.
//

#import "SWPageView.h"

static void * kSWPageViewContext = &kSWPageViewContext;

@interface SWPageView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIView * containerView;
@property (nonatomic,strong) UIScrollView * containerScrollView;
//@property (nonatomic,strong) UIScrollView * currentScrollView;
@end

@implementation SWPageView
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(SWScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[SWScrollView alloc] init];
        _mainScrollView.delegate = self;
        [self addSubview:_mainScrollView];
    }
    return _mainScrollView;
}

-(UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        [self.mainScrollView addSubview:_containerView];
    }
    return _containerView;
}

-(UIScrollView *)containerScrollView{
    if (!_containerScrollView) {
        _containerScrollView = [[UIScrollView alloc] init];
        _containerScrollView.delegate = self;
        [self.containerView addSubview:_containerScrollView];
    }
    return _containerScrollView;
}

-(void)setHeadView:(UIView *)headView{
    _headView = headView;
    [headView removeFromSuperview];
    [self.mainScrollView addSubview:headView];
}

-(void)setSwitchView:(UIView *)switchView{
    _switchView = switchView;
    [switchView removeFromSuperview];
    [self.mainScrollView addSubview:switchView];
}

-(void)setItemViewArray:(NSArray *)itemViewArray{
    _itemViewArray = itemViewArray;
    [itemViewArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            [obj removeFromSuperview];
            [self.containerScrollView addSubview:obj];
            UIScrollView *scrollObj = (UIScrollView *)obj;
            scrollObj.scrollEnabled = NO;
            [obj addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:kSWPageViewContext];
        }
    }];
}

-(void)dealloc{
    [_itemViewArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
        [obj removeObserver:self forKeyPath:@"contentSize"];
    }];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (context == kSWPageViewContext) {
        CGFloat h = _currentScrollView.contentSize.height;
        self.mainScrollView.contentSize = CGSizeMake(0, h + self.headView.height + self.switchView.height);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.mainScrollView.frame = self.bounds;
    self.headView.frame = CGRectMake(0, 0, self.width, self.headHeight);
    self.switchView.frame = CGRectMake(0, 0, self.width, 40);
    self.containerView.frame = CGRectMake(0, 0, self.width, self.height - self.switchView.height);
    self.containerScrollView.frame = self.containerView.bounds;
    [_itemViewArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = self.containerScrollView.bounds;
    }];
    [self layoutOffset];
}


-(void)layoutOffset{
    CGFloat offsetY = self.mainScrollView.contentOffset.y;
    self.switchView.y = MAX(self.headView.bottom, offsetY);
    self.containerView.y = MAX(self.switchView.bottom, offsetY);
    self.currentScrollView.contentOffset = CGPointMake(0, MAX(0, offsetY - self.headView.height));
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollView) {
        [self layoutOffset];
        if ([self.currentScrollView.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
            [self.currentScrollView.delegate scrollViewDidScroll:self.currentScrollView];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollView) {
        if ([self.currentScrollView.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
            [self.currentScrollView.delegate scrollViewWillBeginDragging:self.currentScrollView];
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollView) {
        if ([self.currentScrollView.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
            [self.currentScrollView.delegate scrollViewDidEndDecelerating:self.currentScrollView];
        }
    }
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollView) {
        if ([self.currentScrollView.delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
            [self.currentScrollView.delegate scrollViewWillBeginDecelerating:self.currentScrollView];
        }
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollView) {
        if ([self.currentScrollView.delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
            [self.currentScrollView.delegate scrollViewDidEndScrollingAnimation:self.currentScrollView];
        }
    }
}


@end
