//
//  Drawer_TableViewCell.m
//  XTZL
//
//  Created by 虞海飞 on 16/8/4.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "Drawer_TableViewCell.h"

@implementation Drawer_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDic_Data:(NSDictionary *)dic_Data{
    _dic_Data = dic_Data;

    [self addView];
}

-(void) addView{

    self.label_Title.text = self.dic_Data[@"title"];
    self.label_Conter.text = self.dic_Data[@"conter"];
}

@end
