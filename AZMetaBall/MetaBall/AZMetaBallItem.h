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

@interface AZMetaBallItem : NSObject

@property(nonatomic) UIView *view;

@property(nonatomic) Circle *centerCircle;

@property(nonatomic) Circle *touchCircle;

- (instancetype)initWithView:(UIView *)view;

@end
