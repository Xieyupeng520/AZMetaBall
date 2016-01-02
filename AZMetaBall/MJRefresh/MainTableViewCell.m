//
//  MainTableViewCell.m
//  AZMetaBall
//
//  Created by 阿曌 on 16/1/2.
//  Copyright © 2016年 阿曌. All rights reserved.
//

#import "MainTableViewCell.h"

@interface MainTableViewCell()
@property(nonatomic) NSArray *titleArray;
@property(nonatomic) NSArray *detailTextArray;
@end

@implementation MainTableViewCell

- (void)awakeFromNib {
    
    self.azImageView.clipsToBounds = true;
    self.azImageView.layer.cornerRadius = self.azImageView.frame.size.width/2;
    self.azImageView.image = [UIImage imageNamed:@"face_01"];
    self.azImageView.layer.borderWidth = 1;
    self.azImageView.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.titleArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CellTitle" ofType:@"plist"]];
    self.detailTextArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CellDetailText" ofType:@"plist"]];

}

- (void)setData:(NSIndexPath *)indexPath {
//    int n = arc4random_uniform(9) + 1;
    int n = indexPath.row % 9 + 1;
    
    self.azTextLabel.text = [self.titleArray objectAtIndex:n];
    self.azDetailTextLabel.text = [self.detailTextArray objectAtIndex:n];
    
    
    self.azImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"face_0%d", n]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
