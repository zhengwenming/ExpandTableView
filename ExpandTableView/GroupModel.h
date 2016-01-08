//
//  GroupModel.h
//  ExpandTableView
//
//  Created by 郑文明 on 16/1/8.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject
@property (nonatomic, assign)BOOL isOpened;
@property (nonatomic, retain)NSString *groupName;
@property (nonatomic, assign)NSInteger groupCount;

@property (nonatomic, retain)NSArray *groupFriends;
@end
