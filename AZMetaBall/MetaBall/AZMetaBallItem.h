//
//  AZMetaBallItem.h
//  AZMetaBall
//
//  Created by 阿曌 on 16/1/2.
//  Copyright © 2016年 阿曌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Circle.h"

#define kMax_Distance 75

@interface AZMetaBallItem : NSObject

@property(nonatomic) UIView *view;

@property(nonatomic) Circle *centerCircle;

@property(nonatomic) Circle *touchCircle;

@property(nonatomic) float maxDistance; //最大距离

@property(nonatomic) UIColor *color;    //颜色

- (instancetype)initWithView:(UIView *)view;

@end
