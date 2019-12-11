//
//  SWController1.m
//  SWPageView_Example
//
//  Created by Lemon on 2019/12/11.
//  Copyright © 2019 LemonGui. All rights reserved.
//

#import "SWController1.h"
#import "SWBaseTableView.h"
#import "SWSlideSegmentControl.h"
#import "SWHeadView.h"
#import <SWPageView.h>
@interface SWController1 ()
@property (nonatomic,strong) SWPageView * pageView;
@property (nonatomic,strong) SWSlideSegmentControl *segmentControl;
@end

@implementation SWController1

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.pageView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.pageView];
}

-(SWPageView *)pageView{
    if (!_pageView) {
        __weak typeof(self) __weakSelf = self;
        _pageView = [[SWPageView alloc] init];
        SWHeadView * headView = [[SWHeadView alloc] init];
        headView.backgroundColor = [UIColor redColor];
        headView.btnClickBlock = ^{
            [__weakSelf changeHH];
        };
        _pageView.headView = headView;
        _pageView.headHeight = 150;
        self.segmentControl.height = 50;
        _pageView.switchView = self.segmentControl;
        NSMutableArray * array = @[].mutableCopy;
        for (int i = 0; i < 60; i++) {
            [array addObject:@"测试"];
        }
        SWBaseTableView * table1 = [[SWBaseTableView alloc] initIsGroup:NO];
        table1.dataArray = array.mutableCopy;
        table1.cellBindData = ^(UITableViewCell * _Nonnull cell, NSArray * _Nonnull dataArray, NSIndexPath * _Nonnull indexPath) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@--内容--%ld",dataArray[indexPath.row],indexPath.row];
        };
        SWBaseTableView * table2 = [[SWBaseTableView alloc] initIsGroup:NO];
        table2.dataArray = array.mutableCopy;
        table2.cellBindData = ^(UITableViewCell * _Nonnull cell, NSArray * _Nonnull dataArray, NSIndexPath * _Nonnull indexPath) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@--模块--%ld",dataArray[indexPath.row],indexPath.row];
        };
        table2.cellHeight = ^CGFloat(NSArray * _Nonnull dataArray, NSIndexPath * _Nonnull indexPath) {
            return 60;
        };

        SWBaseTableView * table3 = [[SWBaseTableView alloc] initIsGroup:NO];
        table3.dataArray = array.mutableCopy;
        table3.cellBindData = ^(UITableViewCell * _Nonnull cell, NSArray * _Nonnull dataArray, NSIndexPath * _Nonnull indexPath) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@--文本--%ld",dataArray[indexPath.row],indexPath.row];
        };
        table3.cellHeight = ^CGFloat(NSArray * _Nonnull dataArray, NSIndexPath * _Nonnull indexPath) {
            return 80;
        };

        _pageView.itemViewArray = @[table1,table2,table3];
        _pageView.delegate = self;
        _pageView.index = 1;
        _pageView.topInset = SW_NAV_TOTAL_HEIGHT;
    }
    return _pageView;
}



-(void)changeHH{
    self.pageView.headHeight = self.pageView.headHeight == 150 ? 200 : 150;
    [self.pageView reloadViews];
}

-(SWSlideSegmentControl *)segmentControl{
    if (!_segmentControl) {
        _segmentControl = [[SWSlideSegmentControl alloc] init];
        _segmentControl.titleFontSize = 16;
        _segmentControl.normalbackColor = [UIColor whiteColor];
        _segmentControl.selectBackColor = [UIColor whiteColor];
        _segmentControl.slidBlockEnable = NO;
        _segmentControl.showSlidBottomLine = YES;
        _segmentControl.slidBottomLineHeight = 3;
        _segmentControl.slidBottomLinPadding = 3;
        _segmentControl.durationTime = 0.15;
        _segmentControl.titleArray = @[@"标题0",@"标题1",@"标题2"];
        __weak typeof(self) __weakSelf = self;
        _segmentControl.selectedBlock = ^(NSInteger index) {
            __weakSelf.pageView.index = index;
        };
    }
    return _segmentControl;
}


- (void)pageViewDidSwitch:(SWPageView *)pageView index:(NSInteger)index{
    [self.segmentControl setSelectedIndex:index];
    
}

- (void)pageViewWillSwitch:(SWPageView *)pageView index:(NSInteger)index{
    [self loadTableIndex:index];
}

-(void)pageViewMainScrollViewDidScroll:(SWPageView *)pageView scrollView:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        self.pageView.headView.frame = CGRectMake(0, scrollView.contentOffset.y, scrollView.width, self.pageView.headHeight - scrollView.contentOffset.y) ;
    }else{
//        CGFloat alpha = MIN((scrollView.contentOffset.y/(pageView.headHeight - pageView.topInset)), 0.99);
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage sb_imageWithColor:[RGB_HEX(0xea5504) colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
    }
    
   
}

-(void)loadTableIndex:(NSInteger)index{
    SWBaseTableView * table = (SWBaseTableView *)self.pageView.itemViewArray[index];
    if (!table.isLoadData) {
        [table reloadData];
//        [table refreshTable];
        table.isLoadData = YES;
    }
}

@end
