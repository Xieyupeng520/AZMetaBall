//
//  AZMetaBallCanvas.h
//  AZMetaBall
//
//  Created by 阿曌 on 16/1/2.
//  Copyright © 2016年 阿曌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZMetaBallItem.h"

@interface AZMetaBallCanvas : UIView

@property(nonatomic) AZMetaBallItem *azMetaBallItem;

- (void)attach:(UIView *)item;

@end
