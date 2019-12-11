//
//  SWPageView.m
//
//  Created by Lemon on 2019/12/9.
//

#import "SWPageView.h"
#import "UIView+SWFrame.h"
static void * kSWPageViewContext = &kSWPageViewContext;

@interface SWPageView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIView * switchContainerView;
@property (nonatomic,strong) UIView * containerView;
@property (nonatomic,strong) UIScrollView * containerScrollView;
@property (nonatomic,assign) float lastContentOffsetX;

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
        _containerScrollView.pagingEnabled = YES;
        _containerScrollView.delegate = self;
        _containerScrollView.bounces = NO;
        _containerScrollView.showsHorizontalScrollIndicator = NO;
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
    [self.switchContainerView addSubview:switchView];
}

-(UIView *)switchContainerView{
    if (!_switchContainerView) {
        _switchContainerView = [[UIView alloc] init];
        [self.mainScrollView addSubview:_switchContainerView];
    }
    return _switchContainerView;
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

-(void)setIndex:(NSInteger)index{
    _index = index;
    if (_containerScrollView) {
        [_containerScrollView setContentOffset:CGPointMake(_index * _containerScrollView.width, 0) animated:NO];
    }
    if (_itemViewArray) {
        self.currentScrollView = _itemViewArray[index];
    }
}

-(void)setCurrentScrollView:(UIScrollView *)currentScrollView{
    _currentScrollView = currentScrollView;
    CGFloat h = MAX(_currentScrollView.contentSize.height, _currentScrollView.height);
    if (self.mainScrollView.contentOffset.y < self.headHeight - self.topInset) {
        _currentScrollView.contentOffset = CGPointMake(0, 0);
    }else{
        self.mainScrollView.contentOffset = CGPointMake(0, _currentScrollView.contentOffset.y + self.headHeight - self.topInset);
    }
    self.mainScrollView.contentSize = CGSizeMake(0, h + self.headHeight + self.switchView.height);
}

-(void)dealloc{
    [_itemViewArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
        [obj removeObserver:self forKeyPath:@"contentSize"];
    }];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (context == kSWPageViewContext) {
        CGFloat h = MAX(_currentScrollView.contentSize.height, _currentScrollView.height);
        self.mainScrollView.contentSize = CGSizeMake(0, h + self.headHeight + self.switchView.height);
    }
}

-(void)reloadViews{
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.mainScrollView.frame = self.bounds;
    self.headView.frame = CGRectMake(0, 0, self.width, self.headHeight);
    self.switchContainerView.frame = CGRectMake(0, 0, self.width, self.switchView ? self.switchView.height : 0);
    self.switchView.frame = self.switchContainerView.bounds;
    self.containerView.frame = CGRectMake(0, 0, self.width, self.height - self.switchContainerView.height);
    self.containerScrollView.frame = self.containerView.bounds;
    self.containerScrollView.contentSize = CGSizeMake(_itemViewArray.count * self.containerScrollView.width, 0);
    [_itemViewArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(idx * self.containerScrollView.width, 0, self.containerScrollView.width, self.containerScrollView.height);
    }];
    
    [self layoutOffset];
    
    [_containerScrollView setContentOffset:CGPointMake(_index * _containerScrollView.width, 0) animated:NO];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewDidSwitch:index:)]) {
        self.index = _index;
        self.currentScrollView = self.itemViewArray[_index];
        [self.delegate pageViewDidSwitch:self index:_index];
    }
}


-(void)layoutOffset{
    CGFloat offsetY = self.mainScrollView.contentOffset.y;
    CGFloat del = self.headHeight - self.topInset;
    if (offsetY < del) {
        self.headView.y = 0;
        self.switchContainerView.y = self.headHeight;
        self.containerView.y = self.switchContainerView.bottom;
        self.currentScrollView.contentOffset = CGPointMake(0, 0);
    }else{
        self.headView.bottom = offsetY + self.topInset;
        self.switchContainerView.y = offsetY + self.topInset;
        self.containerView.y = self.switchContainerView.bottom;
        self.currentScrollView.contentOffset = CGPointMake(0, offsetY - del);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollView) {
        [self layoutOffset];
        if ([self.currentScrollView.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
            [self.currentScrollView.delegate scrollViewDidScroll:self.currentScrollView];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewMainScrollViewDidScroll:scrollView:)]) {
            [self.delegate pageViewMainScrollViewDidScroll:self scrollView:scrollView];
        }
    }
    if (scrollView == self.containerScrollView) {
        float singleWidth = scrollView.width;
        NSUInteger index;
        if (scrollView.contentOffset.x > self.lastContentOffsetX) {
            index  = ceil(scrollView.contentOffset.x/singleWidth);
        }else{
            index  = floor(scrollView.contentOffset.x/singleWidth);
        }
        if (self.mainScrollView.contentOffset.y < self.headHeight - self.topInset) {
            ((UIScrollView *)_itemViewArray[index]).contentOffset = CGPointMake(0, 0);
        }
        self.lastContentOffsetX = scrollView.contentOffset.x;
        if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewWillSwitch:index:)]) {
            [self.delegate pageViewWillSwitch:self index:index];
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
    if (scrollView == self.containerScrollView) {
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewDidSwitch:index:)]) {
            self.index = index;
            self.currentScrollView = self.itemViewArray[index];
            [self.delegate pageViewDidSwitch:self index:index];
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
