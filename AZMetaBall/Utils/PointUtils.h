//
//  PointUtils.h
//  AZMetaBall
//
//  Created by 阿曌 on 16/1/3.
//  Copyright © 2016年 阿曌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PointUtils : NSObject

+ (CGPoint)getGlobalCenterPositionOf:(UIView *)view;

+ (CGPoint)getGlobalPositionOf:(UIView *)view;

@end
