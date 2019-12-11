//
//  SWViewController.m
//  SWPageView
//
//  Created by LemonGui on 12/10/2019.
//  Copyright (c) 2019 LemonGui. All rights reserved.
//

#import "SWViewController.h"

@interface SWViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView * table;
@property (nonatomic,strong) NSArray * dataSource;
@end

@implementation SWViewController

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.table.frame = self.view.bounds;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.table];
    self.dataSource = @[
                            @{@"title": @"测试", @"class": @"SWController1"},
//                            @{@"title": @"微博个人主页", @"class": @"GKWBViewController"},
//                            @{@"title": @"微博发现页", @"class": @"GKWBFindViewController"},
//                            @{@"title": @"网易云歌手页", @"class": @"GKWYViewController"},
//                            @{@"title": @"抖音个人主页", @"class": @"GKDYViewController"},
//                            @{@"title": @"主页刷新", @"class": @"GKMainRefreshViewController"},
//                            @{@"title": @"列表刷新", @"class": @"GKListRefreshViewController"},
//                            @{@"title": @"列表懒加载", @"class": @"GKListLoadViewController"},
//                            @{@"title": @"item加载", @"class": @"GKItemLoadViewController"},
//                            @{@"title": @"Header左右滑动", @"class": @"GKHeaderScrollViewController"},
//                            @{@"title": @"VTMagic使用", @"class": @"GKVTMagicViewController"},
    
//                            @{@"title": @"嵌套使用1", @"class": @"GKNest1ViewController"},
//                            @{@"title": @"嵌套使用2", @"class": @"GKNest2ViewController"}
    ];
        
    [self.table reloadData];
	
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSource[indexPath.row][@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.dataSource[indexPath.row];
    
    NSString *className = dic[@"class"];
    
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _table;
}

@end
