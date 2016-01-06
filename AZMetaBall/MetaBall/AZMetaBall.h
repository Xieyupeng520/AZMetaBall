//
//  AZMetaBall.h
//  AZMetaBall
//
//  Created by 阿曌 on 15/12/15.
//  Copyright © 2015年 阿曌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Circle.h"


#define RADIUS 40.0
//#define IS_FILL true
//#define IS_STROKE true


@interface AZMetaBall : UIView

@property(nonatomic,strong) Circle *centerCircle;
@property(nonatomic,strong) Circle *touchCircle;

@property(nonatomic) bool isFill;

//改变半径
-(void)changeCenterCircleRadiusTo:(float)radius;
-(void)changeTouchCircleRadiusTo:(float)radius;


@end
