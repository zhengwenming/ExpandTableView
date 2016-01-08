//
//  ViewController.m
//  ExpandTableView
//
//  Created by 郑文明 on 16/1/8.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "ViewController.h"
#import "ExpandTableViewController.h"
#import "FoldTableViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView * table;
    NSMutableArray *dataSource;
}

@end

@implementation ViewController
-(void)initTable{
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate =  self;
    table.tableFooterView = [UIView new];
    [self.view addSubview:table];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [NSMutableArray arrayWithObjects:@"折叠收缩table例子1",@"折叠收缩table例子2", nil];
    [self initTable];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = dataSource[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {//折叠收缩table例子1
        ExpandTableViewController *expandVC = [[ExpandTableViewController alloc]init];
        [self.navigationController pushViewController:expandVC animated:YES];
    }else if (indexPath.row==1){//折叠收缩table例子2
        FoldTableViewController *foldVC = [[FoldTableViewController alloc]init];
        [self.navigationController pushViewController:foldVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
