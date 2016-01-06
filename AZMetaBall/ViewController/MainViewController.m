//
//  MainViewController.m
//  AZMetaBall
//
//  Created by 阿曌 on 16/1/2.
//  Copyright © 2016年 阿曌. All rights reserved.
//

#import "MainViewController.h"
#import "MJRefresh.h"
#import "MainTableViewCell.h"
#import "AZMetaBallCanvas.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITableView *listView;
@property (weak, nonatomic) IBOutlet AZMetaBallCanvas *azMetaBallView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak UITableView *tableView = self.listView;
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_header endRefreshing];
            
            [self.listView reloadData];
        });
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //注册自定义Cell
    [tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"MainTableViewCell";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    [cell setData:indexPath];
    
    //给所有的红点加上监听事件
    [self.azMetaBallView attach:cell.azImageView];
    [self.azMetaBallView attach:cell.azAccessoryView];
    [self.azMetaBallView attach:cell.azTextLabel];
    [self.azMetaBallView attach:cell.azDetailTextLabel];
    [self.azMetaBallView attach:cell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

//选中时取消选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.listView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"toDetail" sender:nil];
//    [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
