//
//  SWBaseTableView.h
//  SWPageView_Example
//
//  Created by Lemon on 2019/12/11.
//  Copyright © 2019 LemonGui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIView+SWFrame.h>

#define SW_STATUSBAR_HEIGHT    [UIApplication sharedApplication].statusBarFrame.size.height
#define SW_NAVIGATION_HEIGHT   44.0f
#define SW_NAV_TOTAL_HEIGHT    (SW_STATUSBAR_HEIGHT + SW_NAVIGATION_HEIGHT)
NS_ASSUME_NONNULL_BEGIN

@interface SWBaseTableView : UITableView
@property (nonatomic,assign) BOOL isLoadData;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,assign) Class sDataClass;

@property (nonatomic,copy) void(^cellBindData)(UITableViewCell * cell, NSArray * dataArray, NSIndexPath *indexPath);
@property (nonatomic,copy) CGFloat(^cellHeight)(NSArray * dataArray, NSIndexPath *indexPath);

- (instancetype)initIsGroup:(BOOL)isGroup;

@end

NS_ASSUME_NONNULL_END
