//
//  ResultsViewController.m
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import "ResultsViewController.h"
#import "MJRefresh.h"
#import "FriendTableViewCell.h"
#import "LoadingTool.h"
#import "Masonry.h"
#import "ResultModel.h"

@interface ResultsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) ResultsViewModel *viewModel;

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation ResultsViewController
- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadTableView:YES];
        }];
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadTableView:NO];
        }];
        [self.view addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.top.equalTo(self.view).offset([UIApplication sharedApplication].statusBarFrame.size.height + 44);//
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
        
        _tableView = tableView;
    }
    
    return _tableView;
}

+ (instancetype)resultsViewControllerWithViewModel:(ResultsViewModel *)viewModel {
    return [[self alloc] initWithViewModel:viewModel];
}
- (instancetype)initWithViewModel:(ResultsViewModel *)viewModel {
    if (self = [super init]) {
        self.viewModel = viewModel;
    }
    
    return self;
}

#pragma makr - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUi];
    [self bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadTableView:YES];
}

#pragma mark - 自定义方法
- (void)bindViewModel {
    @weakify(self)
    [[RACObserve(self.viewModel, dataArr) filter:^BOOL(id  _Nullable value) {
        return value;
    }] subscribeNext:^(NSArray *x) {
        @strongify(self)
        [self.tableView reloadData];
    }];
    // 这段代码的意思是若0.3秒内无新信号(tf无输入),并且输入框内不为空那么将会执行,这对服务器的压力减少有巨大帮助同时提高了用户体验
    [[[[RACObserve(self.viewModel, searchContent) throttle:0.3] distinctUntilChanged] ignore:@""] subscribeNext:^(NSString *x) {
        if (x == nil || x.length == 0) {
            [self.tableView removeFromSuperview];
            self.tableView = nil;
        }else {
            [self loadTableView:YES];
        }
    }];
    
}
- (void)settingUi {
    self.view.backgroundColor = [UIColor clearColor];
}
/**
 加载tableView
 
 @param isDown 是否为下拉加载
 */
- (void)loadTableView:(BOOL)isDown {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[self.viewModel searchSignal:isDown] subscribeNext:^(ResultModel *model) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (model.success) {
            if (model.dataModel == nil || [(NSArray *)model.dataModel count] == 0) {
                [LoadingTool showMessage:isDown ? @"没有数据" : @"没有跟多数据" toView:self.view];
            }
        } else {
            [LoadingTool showMessage:model.message toView:self.view];
        }
        if (isDown) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [FriendTableViewCell friendCell:tableView viewModel:[self.viewModel.dataArr objectAtIndex:indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[self.viewModel didSelectedSignalWithIndex:indexPath.row] subscribeNext:^(FriendModel * model) {
        NSLog(@"---->您点击的是%@",model);
    }];
}

#pragma mark - <UISearchBarDelegate>代理方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.tableView.mj_header beginRefreshing];
}

@end
