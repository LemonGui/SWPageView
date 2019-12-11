//
//  SWSlideSegmentControl.h
//
//  Created by Lemon on 2019/3/18.
//  滑动切换样式Segment

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWSlideSegmentControl : UIView
//正常背景色
@property (nonatomic,strong) UIColor * normalbackColor;
//选中背景色
@property (nonatomic,strong) UIColor * selectBackColor;
//正常字体颜色
@property (nonatomic,strong) UIColor * normalTitleColor;
//选中字体颜色
@property (nonatomic,strong) UIColor * selectTitleColor;
//字体大小
@property (nonatomic,assign) CGFloat titleFontSize;
//标题
@property (nonatomic,strong) NSArray <NSString *>* titleArray;
//滑动时间
@property (nonatomic,assign) CGFloat durationTime;
//滑块ShowColor
@property (nonatomic,strong) UIColor * slidShowColor;

//显示底部滑条，默认NO
@property (nonatomic,assign) BOOL showSlidBottomLine;
//底部滑条颜色
@property (nonatomic,strong) UIColor * slidBottomLineColor;
//底部滑条高
@property (nonatomic,assign) CGFloat slidBottomLineHeight;
//底部滑条宽
@property (nonatomic,assign) CGFloat slidBottomLineWidth;
//底部滑条距离底部间隙
@property (nonatomic,assign) CGFloat slidBottomLinPadding;

//支持滑动切换，默认YES
@property (nonatomic,assign) BOOL slidBlockEnable;
//滑块圆角
@property (nonatomic,assign) CGFloat slidCornerRadius;

//滑块区域和外边界间距
@property (nonatomic,assign) CGFloat slidMargin;

//全图点击翻转，适用于2个按钮,类似UISWitch点击切换效果
@property (nonatomic,assign) BOOL switchActionMode;

@property (nonatomic,assign,readonly) NSInteger currentIndex;

//回调
@property (nonatomic,copy) void(^selectedBlock)(NSInteger index);

-(void)setSelectedIndex:(NSInteger)index;

//带回调
-(void)clickIndex:(NSInteger)index;

-(UIButton *)getBtnWithIndex:(NSInteger)index;

//调节指定位置ContentEdgeInsets
-(void)setContentEdgeInsets:(UIEdgeInsets)insets index:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
