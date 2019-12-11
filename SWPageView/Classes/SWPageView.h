//
//  SWPageView.h
//
//  Created by Lemon on 2019/12/9.
//

#import <UIKit/UIKit.h>
#import "SWScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@class SWPageView;
@protocol SWPageViewDelegate <NSObject>

@required
//itemScrollView切换
-(void)pageViewDidSwitch:(SWPageView *)pageView index:(NSInteger)index;

@optional
//itemScrollView将要切换
-(void)pageViewWillSwitch:(SWPageView *)pageView index:(NSInteger)index;
//底层MainScrollView滚动
-(void)pageViewMainScrollViewDidScroll:(SWPageView *)pageView scrollView:(UIScrollView *)scrollView;
@end

@interface SWPageView : UIView
@property (nonatomic,strong) SWScrollView * mainScrollView;
@property (nonatomic,strong) UIView * headView;
@property (nonatomic,strong) UIView * switchView;
@property (nonatomic,weak) id delegate;
//顶部忽略悬停偏移量
@property (nonatomic,assign) CGFloat topInset;
//头部高度
@property (nonatomic,assign) CGFloat headHeight;
//当前滚动的ScrollView
@property (nonatomic,strong) UIScrollView * currentScrollView;
//itemScrollView的数组
@property (nonatomic,strong) NSArray <UIScrollView *>* itemViewArray;
//正在滚动的itemScrollView index
@property (nonatomic,assign) NSInteger index;

//改变headHeight后调用
-(void)reloadViews;

@end

NS_ASSUME_NONNULL_END
