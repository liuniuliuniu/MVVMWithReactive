//
//  LLBlogView.m
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLBlogView.h"

#import "LLBlogCell.h"

static NSString *CellID = @"LLBlogViewID";

@interface LLBlogView ()

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)LLBlogVIewModel *viewModel;


@end

@implementation LLBlogView

+ (instancetype)blogViewWithViewModel:(LLBlogVIewModel *)viewModel{

    return [[LLBlogView alloc]initWithVIewModel:viewModel];

}

- (instancetype)initWithVIewModel:(LLBlogVIewModel *)viewModel{
    
    if (self = [super init]) {
        
        
        self.tableView = ({
            UITableView *tab = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
            tab.delegate = self;
            tab.dataSource = self;
            tab;
        });
        
        self.viewModel = viewModel;
        
        [self.tableView registerNib:[UINib nibWithNibName:@"LLBlogCell" bundle:nil] forCellReuseIdentifier:CellID];
        
        @weakify(self);
//        请求数据
        self.fetchDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            
            RACSubject *subject = [RACSubject subject];
            
            [self.viewModel.refreshDataSignal subscribeError:^(NSError *error) {
               
                [subject sendError:error];
            }completed:^{
              
                [self.tableView reloadData];
                
                [subject sendCompleted];
                
            } ];
            
            return subject;
        }];
        
        //  刷新数据
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           @strongify(self);
            
            
            [self.viewModel.refreshDataSignal subscribeError:^(NSError *error) {
             
                [self.tableView.mj_header endRefreshing];
                
            }completed:^{
               
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
                
            }];
        }];
        
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           @strongify(self);
            
            [self.viewModel.loadMoreDataSignal subscribeError:^(NSError *error) {
               
                [self.tableView.mj_footer endRefreshing];
                [self.tableView showToastWithText:error.domain];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
                
            }completed:^{
                [self.tableView reloadData];
                [self.tableView.mj_footer endRefreshing];
            }];
        }];
        
    }
    return self;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.allDatas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LLBlogCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    cell.viewModel = self.viewModel.allDatas[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.didSelectCommand execute:self.viewModel.allDatas[indexPath.row].blog];

}





@end
