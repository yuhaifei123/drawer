//
//  Drawer_TableView.h
//  XTZL
//
//  Created by 虞海飞 on 16/8/3.
//  Copyright © 2016年 虞海飞. All rights reserved.
//  抽屉样式，tableView

#import <UIKit/UIKit.h>

@interface Drawer_TableView : UITableView<UITableViewDelegate,UITableViewDataSource>{

    //控制，多少个抽屉
    BOOL close[4];
}

/**  别人调用数据源 */
@property (nonatomic,strong) NSMutableArray *array_Data;

@end
