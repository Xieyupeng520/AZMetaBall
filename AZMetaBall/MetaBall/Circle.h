//
//  Circle.h
//  AZMetaBall
//
//  Created by 阿曌 on 15/12/19.
//  Copyright © 2015年 阿曌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Circle : NSObject

@property(nonatomic) float radius;
@property(nonatomic) CGPoint centerPoint;

@property(nonatomic) UIColor *color;

//记录一下原始的圆的大小
@property(nonatomic) float orignRadius;

+ (instancetype)initWithcenterPoint:(CGPoint)center radius:(float)radius;
+ (instancetype)initWithcenterPoint:(CGPoint)center radius:(float)radius color:(UIColor *)color;

@end
