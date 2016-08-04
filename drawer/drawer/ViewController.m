//
//  ViewController.m
//  drawer
//
//  Created by 虞海飞 on 16/8/4.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "ViewController.h"
#import "Drawer_TableView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet Drawer_TableView *ywwd_tableView;//表格
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
