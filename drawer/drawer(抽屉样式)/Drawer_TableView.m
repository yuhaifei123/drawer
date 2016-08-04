//
//  Drawer_TableView.m
//  XTZL
//
//  Created by 虞海飞 on 16/8/3.
//  Copyright © 2016年 虞海飞. All rights reserved.
//  抽屉样式，tableView

#import "Drawer_TableView.h"
#import "Masonry.h"
#import "Drawer_TableViewCell.h"

#define Screenwidth [UIScreen mainScreen].bounds.size.width
#define ScreennHeight [UIScreen mainScreen].bounds.size.height

@implementation Drawer_TableView

-(NSMutableArray *) array_Data{

    if (_array_Data == nil) {

        NSDictionary *dic_01 = [NSDictionary dictionaryWithObjectsAndKeys:@"购，建。修房提取住房公积金",@"title",@"购房",@"conter",nil];
        NSDictionary *dic_02 = [NSDictionary dictionaryWithObjectsAndKeys:@"购，建。修房提取住房公积金",@"title",@"建，修房",@"conter",nil];
        NSDictionary *dic_03 = [NSDictionary dictionaryWithObjectsAndKeys:@"【点击查看更多】",@"title",@"",@"conter",nil];
        NSArray *array = [NSArray arrayWithObjects:dic_01,dic_02,dic_03, nil];
        NSArray *array_01 = [NSArray new];
        NSArray *array_02 = [NSArray new];
        NSArray *array_03 = [NSArray new];

        _array_Data = [NSMutableArray arrayWithObjects:array,array_01,array_02,array_03,nil];
    }
    return _array_Data;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];

    if (self != nil) {

        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [UIView new];

        //这个的目的是为了使得启动app时，单元格是收缩的
        for (int i=0; i<4; i++) {
            close[i] = YES;
        }
        close[0] = NO;
       // [self getHttp_Data];
        //默认开启是false
        cell_Number = false;
    }

    return self;
}

/**
 *  网络请求数据
 */
//-(void) getHttp_Data{
//
//    //对外数据，端口有数据时，这个这个方法，就不会调用
//    if (self.array_Data == nil) {
//
//        Url *url = [Url new];
//        NSString *stringData = @"id :'0', column : '业务网点', top :'1'";
//        NSDictionary *dic = [GetHttp mergeData_String:stringData Transcode:@"020404"];
//
//        [GetHttp afhPostHttp_Url:url.string_Path Parameters:dic DicData:^(id data) {
//
//            NSLog(@"%@",data);
//
//            //更新uitable
//           // [weakSelf reloadData];
//        }];
//    }
//
//    return;
//}

/****************** uitableView delegate   ***************/
//数据源方法的实现
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (close[section]) {
        return 0;
    }
    NSArray *array = self.array_Data[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Drawer_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Drawer_TableViewCell"];
    if (cell == nil) {
        //把xib加进来
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Drawer_TableViewCell" owner:nil options:nil]lastObject];

    }
    NSArray *array = self.array_Data[indexPath.section];
    cell.dic_Data = array[indexPath.row];

    return cell;
}

//组头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

//创建组头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return [self addUIControl_Section:section];
}

/**
 * 创建头部view
 */
-(UIControl *) addUIControl_Section:(NSInteger)section{

    UIControl *view = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, 50)];;
    view.backgroundColor = [UIColor colorWithRed:235/255 green:235/255 blue:235/255 alpha:0.1];
    view.tag = 1000 + section;
    [view addTarget:self action:@selector(sectionClick:) forControlEvents:UIControlEventTouchDown];

    //设置标题
    NSString *string_Title = @"";
    switch (section) {
        case 0:
            string_Title = @"支取类";
            break;

        case 1:
            string_Title = @"还贷类";
            break;

        case 2:
            string_Title = @"贷款类";
            break;

        case 3:
            string_Title = @"缴存类";
            break;

        default:
            break;
    }

    //添加view
    UILabel *label_Title = [UILabel new];
    label_Title.font = [UIFont fontWithName:@"Arial" size:20];
    label_Title.text = string_Title;
    label_Title.textColor = [UIColor colorWithRed:235/255 green:235/255 blue:235/255 alpha:0.4];
    [view addSubview:label_Title];
    [label_Title mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(view).with.offset(0);
        make.left.equalTo(view).with.offset(10);
        make.bottom.equalTo(view).with.offset(0);
        make.width.mas_equalTo(@100);
    }];

    //箭头
    UIImageView *imageView_Arrow = [UIImageView new];
    UIImage *image = nil;
    //如果是 第一组，箭头是倒
    (close[section] == NO) ? (image= [UIImage imageNamed:@"arrow_B"]) : (image = [UIImage imageNamed:@"arrow"]);

    [imageView_Arrow setImage:image];
    [view addSubview:imageView_Arrow];
    [imageView_Arrow mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.mas_equalTo(view).with.offset(-10);
        make.top.mas_equalTo(view).with.offset(10);
        make.bottom.mas_equalTo(view).with.offset(-10);
        make.width.mas_equalTo(@30);
    }];

    return view;
}

/**
 *  点击头，出现隐藏功能
 *
 *  @param view <#view description#>
 */
-(void)sectionClick:(UIControl *)view{

    //获取点击的组
    NSInteger i = view.tag - 1000;
    //取反
    close[i] = !close[i];

    //得到uiiamgeView的视图
    NSArray *array_View = view.subviews;
    UIImageView *imageView = array_View[1];
    //添加旋转动画
    [UIView animateWithDuration: 0.5 delay: 0.35 options: UIViewAnimationOptionTransitionCurlUp  animations: ^{

         imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI);

    } completion: ^(BOOL finished) {

        //刷新列表
        NSIndexSet * index = [NSIndexSet indexSetWithIndex:i];
        [self reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

/**
 选择了table里面的cell，触发的事件
 */
static bool cell_Number = false;//默认是只能点击一次（展开）
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 && indexPath.row == 2 && cell_Number == false ) {

        NSDictionary *dic_01 = [NSDictionary dictionaryWithObjectsAndKeys:@"购，建。修房提取住房公积金",@"title",@"购房",@"conter",nil];
        NSDictionary *dic_02 = [NSDictionary dictionaryWithObjectsAndKeys:@"购，建。修房提取住房公积金",@"title",@"建，修房",@"conter",nil];
        NSDictionary *dic_03 = [NSDictionary dictionaryWithObjectsAndKeys:@"家庭生活困难支取住房公积金",@"title",@"",@"conter",nil];
        NSDictionary *dic_04 = [NSDictionary dictionaryWithObjectsAndKeys:@"其他情况支取住房公积金",@"title",@"",@"conter",nil];
        NSDictionary *dic_05 = [NSDictionary dictionaryWithObjectsAndKeys:@"住房提取住房公积金",@"title",@"",@"conter",nil];
        NSArray *array = [NSArray arrayWithObjects:dic_01,dic_02,dic_04,dic_03,dic_05, nil];

        [self.array_Data replaceObjectAtIndex:0 withObject:array];

        //刷新列表
        NSIndexSet * index = [NSIndexSet indexSetWithIndex:0];
        [self reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];
        cell_Number = true;
    }
    [self deselect];
}

/**
 *  uitableViewCell的动态高度
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = self.array_Data[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    if (dic[@"conter"] == nil || [[NSString stringWithFormat:@"%@",dic[@"conter"]] isEqualToString:@""]) {

        return 40.0;
    }
    return 60.0;
}

/**
 清除缓存调用的方法 cell点击以后的阴影
 */
- (void)deselect{

    [self deselectRowAtIndexPath:[self indexPathForSelectedRow] animated:YES];
}

@end
