//
//  MainTableViewCell.h
//  AZMetaBall
//
//  Created by 阿曌 on 16/1/2.
//  Copyright © 2016年 阿曌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *azImageView;
@property (weak, nonatomic) IBOutlet UITextField *azTextLabel;
@property (weak, nonatomic) IBOutlet UITextField *azDetailTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *azAccessoryView;

- (void)setData:(NSIndexPath *)indexPath;
@end
