//
//  SWPageView.h
//  SBBarModule
//
//  Created by Lemon on 2019/12/9.
//

#import <UIKit/UIKit.h>
#import "SWScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWPageView : UIView
@property (nonatomic,strong) SWScrollView * mainScrollView;
@property (nonatomic,strong) UIView * headView;
@property (nonatomic,strong) UIView * switchView;

@property (nonatomic,assign) CGFloat headHeight;

@property (nonatomic,strong) UIScrollView * currentScrollView;

@property (nonatomic,strong) NSArray * itemViewArray;

@end

NS_ASSUME_NONNULL_END
