//
//  DetileTableViewCell.h
//  RACTest
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 com.zaoguankeji.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestViewModel.h"
#import "UIImageView+WebCache.h"
@interface DetileTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UILabel *bookPublisher;
@property (weak, nonatomic) IBOutlet UILabel *bookPubDate;
@property (strong, nonatomic) Books *model;
@end
