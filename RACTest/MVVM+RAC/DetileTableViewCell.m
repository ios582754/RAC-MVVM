//
//  DetileTableViewCell.m
//  RACTest
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 com.zaoguankeji.www. All rights reserved.
//

#import "DetileTableViewCell.h"

@implementation DetileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(Books *)model {
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.image]] ;
    self.bookName.text = model.title;
    self.bookPubDate.text = model.pubdate;
    self.bookPublisher.text = model.publisher;
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
