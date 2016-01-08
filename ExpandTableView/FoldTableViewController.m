
//
//  FoldTableViewController.m
//  ExpandTableView
//
//  Created by 郑文明 on 16/1/8.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "FoldTableViewController.h"
#import "FriendCell.h"
#import "GroupModel.h"
#import <objc/runtime.h>
char* const buttonKey = "buttonKey";



#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface FoldTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView     *expandTable;
    NSMutableArray  *dataSource;
    
}

@end

@implementation FoldTableViewController

- (void)initDataSource
{
    dataSource = [[NSMutableArray alloc]init];
    NSDictionary *JSONDic =@{@"group":
  @[
  @{@"groupName":@"小学同学",@"groupCount":@"3",@"groupArray":@[
                                        @{@"name":@"小明",@"avatarURL":@"",@"shuoshuo":@"作业又没写好,唉！",@"status":@"1"},
                                        @{@"name":@"小红",@"avatarURL":@"",@"shuoshuo":@"考试不要抄我的！",@"status":@"1"},
                                        @{@"name":@"小王",@"avatarURL":@"",@"shuoshuo":@"马勒戈壁有本事放学别走！",@"status":@"0"}
                                        ]},
  @{@"groupName":@"初中同学",@"groupCount":@"5",@"groupArray":
                                        @[
                                        @{@"name":@"王二小",@"avatarURL":@"",@"shuoshuo":@"我家来自农村，不要欺负我",@"status":@"1"},
                                        @{@"name":@"王麻子",@"avatarURL":@"",@"shuoshuo":@"历史咯老师真漂亮！",@"status":@"1"},
                                        @{@"name":@"吴道德",@"avatarURL":@"",@"shuoshuo":@"我姓吴，法号道德",@"status":@"1"},
                                        @{@"name":@"张丝丹",@"avatarURL":@"",@"shuoshuo":@"我小名叫四蛋子，哈哈",@"status":@"0"},
                                        @{@"name":@"赵铁柱",@"avatarURL":@"",@"shuoshuo":@"我喜欢小花",@"status":@"0"}
                                        ]},
  @{@"groupName":@"高中同学",@"groupCount":@"3",@"groupArray":
                                        @[
                                        @{@"name":@"刘阿猫",@"avatarURL":@"",@"shuoshuo":@"我操，高考又到了",@"status":@"1"},
                                        @{@"name":@"静静",@"avatarURL":@"",@"shuoshuo":@"大家好，我是静静。",@"status":@"1"},
                                        @{@"name":@"隔壁老王",@"avatarURL":@"",@"shuoshuo":@"小样你是新来的吧！",@"status":@"0"}
                                        ]},
  @{@"groupName":@"大学同学",@"groupCount":@"4",@"groupArray":
                                        @[
                                        @{@"name":@"屌丝男",@"avatarURL":@"",@"shuoshuo":@"泡妞去了，回聊。",@"status":@"1"},
                                        @{@"name":@"游戏狗",@"avatarURL":@"",@"shuoshuo":@"我擦，双杀！！",@"status":@"1"},
                                        @{@"name":@"学霸",@"avatarURL":@"",@"shuoshuo":@"期末考试稳拿第一",@"status":@"1"},
                                        @{@"name":@"书呆子",@"avatarURL":@"",@"shuoshuo":@"蛋白质是怎么炼成的。。。",@"status":@"0"}]},
  @{@"groupName":@"同事",@"groupCount":@"3",@"groupArray":
                                        @[
                                        @{@"name":@"JAVA工程师",@"avatarURL":@"",@"shuoshuo":@"JAVA是最好的编程语言",@"status":@"1"},
                                        @{@"name":@"Android工程师",@"avatarURL":@"",@"shuoshuo":@"Android最好用，便宜耐摔！",@"status":@"1"},
                                        @{@"name":@"iOS工程师",@"avatarURL":@"",@"shuoshuo":@"iPhone手机牛逼又流畅。",@"status":@"0"}
                                        ]},
  @{@"groupName":@"家人",@"groupCount":@"3",@"groupArray":
                                        @[
                                        @{@"name":@"妈妈",@"avatarURL":@"",@"shuoshuo":@"今天天气好晴朗☀️，处处好风光",@"status":@"1"},
                                        @{@"name":@"爸爸",@"avatarURL":@"",@"shuoshuo":@"农家乐！",@"status":@"1"},
                                        @{@"name":@"姐姐",@"avatarURL":@"",@"shuoshuo":@"唱歌跳舞样样精通。",@"status":@"0"}
                                        ]}
  ]
  };
    
    for (NSDictionary *groupInfoDic in JSONDic[@"group"]) {
        GroupModel *model = [[GroupModel alloc]init];
        model.groupName = groupInfoDic[@"groupName"];
        model.groupCount = [groupInfoDic[@"groupCount"] integerValue];
        model.isOpened = NO;
        model.groupFriends = groupInfoDic[@"groupArray"];
        [dataSource addObject:model];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"QQ好友分组";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDataSource];
    [self initTable];
}
-(void)initTable{
    expandTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    expandTable.dataSource = self;
    expandTable.delegate =  self;
    expandTable.tableFooterView = [UIView new];
    [expandTable registerNib:[UINib nibWithNibName:@"FriendCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:expandTable];
}

#pragma mark -
#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GroupModel *groupModel = dataSource[section];
    NSInteger count = groupModel.isOpened?groupModel.groupFriends.count:0;
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    GroupModel *groupModel = dataSource[indexPath.section];
    NSDictionary *friendInfoDic = groupModel.groupFriends[indexPath.row];
    cell.nameLabel.text = friendInfoDic[@"name"];
    
    if ([friendInfoDic[@"status"] isEqualToString:@"1"]) {
        cell.statusLabel.textColor = [UIColor greenColor];
        cell.statusLabel.text = @"在线";
    }else{
        cell.statusLabel.textColor = [UIColor lightGrayColor];
        cell.statusLabel.text = @"不在线";
    }
    cell.shuoshuoLabel.text = friendInfoDic[@"shuoshuo"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    sectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
    GroupModel *groupModel = dataSource[section];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:sectionView.bounds];
    [button setTag:section];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitle:groupModel.groupName forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [sectionView addSubview:button];
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, button.frame.size.height-1, button.frame.size.width, 1)];
    [line setImage:[UIImage imageNamed:@"line_real"]];
    [sectionView addSubview:line];
    if (groupModel.isOpened) {
        UIImageView * _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (44-16)/2, 14, 16)];
        [_imgView setImage:[UIImage imageNamed:@"ico_list"]];
        [sectionView addSubview:_imgView];
        CGAffineTransform currentTransform = _imgView.transform;
        CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, M_PI/2); // 在现在的基础上旋转指定角度
        _imgView.transform = newTransform;
        objc_setAssociatedObject(button, buttonKey, _imgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    }else{
        UIImageView * _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (44-16)/2, 14, 16)];
        [_imgView setImage:[UIImage imageNamed:@"ico_list"]];
        [sectionView addSubview:_imgView];
        objc_setAssociatedObject(button, buttonKey, _imgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    }
  

    
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40, (44-20)/2, 40, 20)];
    [numberLabel setBackgroundColor:[UIColor clearColor]];
    [numberLabel setFont:[UIFont systemFontOfSize:14]];
    NSInteger onLineCount = 0;
    for (NSDictionary *friendInfoDic in groupModel.groupFriends) {
        if ([friendInfoDic[@"status"] isEqualToString:@"1"]) {
            onLineCount++;
        }
    }
    [numberLabel setText:[NSString stringWithFormat:@"%ld/%ld",onLineCount,groupModel.groupCount]];
    [sectionView addSubview:numberLabel];
    
    return sectionView;
}
#pragma mark
#pragma mark  -select cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupModel *groupModel = dataSource[indexPath.section];
    NSDictionary *friendInfoDic = groupModel.groupFriends[indexPath.row];
    NSLog(@"%@ %@",friendInfoDic[@"name"],friendInfoDic[@"shuoshuo"]);
}

- (void)buttonPress:(UIButton *)sender//headButton点击
{
    GroupModel *groupModel = dataSource[sender.tag];
    UIImageView *imageView =  objc_getAssociatedObject(sender,buttonKey);

    
    if (groupModel.isOpened) {
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
                CGAffineTransform currentTransform = imageView.transform;
                CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, -M_PI/2); // 在现在的基础上旋转指定角度
                imageView.transform = newTransform;


            } completion:^(BOOL finished) {
                

            }];
        
        
        
    }else{
        
            [UIView animateWithDuration:0.3 delay:0.0 options: UIViewAnimationOptionAllowUserInteraction |UIViewAnimationOptionCurveLinear animations:^{

                CGAffineTransform currentTransform = imageView.transform;
                CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, M_PI/2); // 在现在的基础上旋转指定角度
                imageView.transform = newTransform;
            
            } completion:^(BOOL finished) {
                
            }];
        }

    groupModel.isOpened = !groupModel.isOpened;

    [expandTable reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
