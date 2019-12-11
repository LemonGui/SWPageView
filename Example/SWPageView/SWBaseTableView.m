//
//  SWBaseTableView.m
//  SWPageView_Example
//
//  Created by Lemon on 2019/12/11.
//  Copyright © 2019 LemonGui. All rights reserved.
//

#import "SWBaseTableView.h"

@interface SWBaseTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SWBaseTableView

- (instancetype)initIsGroup:(BOOL)isGroup{
    return [self initWithFrame:CGRectZero style:isGroup ? UITableViewStyleGrouped : UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        [self prepareInitTable];
    }
    return self;
}

-(void)prepareInitTable{
    
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    if (!self.sDataClass) {
        self.sDataClass = [UITableViewCell class];
    }
}

-(void)setSDataClass:(Class)sDataClass{
    _sDataClass = sDataClass;
    [self registerClass:sDataClass forCellReuseIdentifier:[NSString stringWithFormat:@"%@-Identifier",NSStringFromClass(sDataClass)]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@-Identifier",NSStringFromClass(self.sDataClass)] forIndexPath:indexPath];
    if (self.cellBindData) {
        self.cellBindData(cell, self.dataArray, indexPath);
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellHeight) {
        return self.cellHeight(self.dataArray,indexPath);
    }
    return 44;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

@end
