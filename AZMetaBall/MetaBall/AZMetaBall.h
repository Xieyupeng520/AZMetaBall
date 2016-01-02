//
//  AZMetaBall.h
//  AZMetaBall
//
//  Created by 阿曌 on 15/12/15.
//  Copyright © 2015年 阿曌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Circle.h"


#define RADIUS 30.0
#define IS_FILL false
#define IS_STROKE true

@protocol AZMetaBallDelegate <NSObject>

//根据连心线的长度来做相应的事
-(void)onDistanceOf:(float)d;

-(void)onMaxDistance;

@end
@interface AZMetaBall : UIView

@property(nonatomic,strong) Circle *centerCircle;
@property(nonatomic,strong) Circle *touchCircle;

//改变半径
-(void)changeCenterCircleRadiusTo:(float)radius;
-(void)changeTouchCircleRadiusTo:(float)radius;


@end
