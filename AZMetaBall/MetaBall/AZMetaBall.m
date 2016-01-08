//
//  AZMetaBall.m
//  AZMetaBall
//
//  Created by 阿曌 on 15/12/15.
//  Copyright © 2015年 阿曌. All rights reserved.
//

#import "AZMetaBall.h"

#import "Math.h"

@interface AZMetaBall() {
    UIBezierPath *_path;
    
    CGPoint _touchPoint;
    
    bool _isFill;
}

@end
@implementation AZMetaBall

- (instancetype)init {
    self = [super init];
    NSLog(@"init");
    if (self) {
        [self initData];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    NSLog(@"initWithFrame");
    if (self) {
        [self initData];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    NSLog(@"initWithCorder");
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData {
    _isFill = NO;
    
    _touchCircle = [Circle initWithcenterPoint:self.center radius:RADIUS color:[UIColor redColor]];
    _centerCircle = [Circle initWithcenterPoint:self.center radius:RADIUS color:[UIColor blueColor]];
    
    _touchPoint = self.center;
    
    NSLog(@"self.center (%f, %f)", self.center.x, self.center.y);
}

- (void)drawRect:(CGRect)rect {
    _path = [[UIBezierPath alloc] init];
    
    [self drawCenterCircle];
    
    [self drawTouchCircle:_touchPoint];
    
    [self drawBezierCurveWithCircle1:_centerCircle Circle2:_touchCircle];
    
}

#pragma mark  - public方法 -
#pragma 改变半径
-(void)changeCenterCircleRadiusTo:(float)radius {
    _centerCircle.radius = radius;
    [self setNeedsDisplay];
}
-(void)changeTouchCircleRadiusTo:(float)radius {
    _touchCircle.radius = radius;
    [self setNeedsDisplay];
}
#pragma mark  - private方法 -

#pragma mark draw curve
- (void)drawBezierCurveWithCircle1:(Circle *)circle1 Circle2:(Circle *)circle2 {
    float circle1_x = circle1.centerPoint.x;
    float circle1_y = circle1.centerPoint.y;
    float circle2_x = circle2.centerPoint.x;
    float circle2_y = circle2.centerPoint.y;
    
    //连心线的长度
    float d = sqrt(powf(circle1_x - circle2_x, 2) + powf(circle1_y - circle2_y, 2));
//    [self drawLineStartAt:circle1.centerPoint EndAt:circle2.centerPoint];
    
    //连心线x轴的夹角
    float angle1 = atan((circle2_y - circle1_y) / (circle1_x - circle2_x));
    //连心线和公切线的夹角
    float angle2 = asin((circle1.radius - circle2.radius) / d);
    //切点到圆心和x轴的夹角
    float angle3 = M_PI_2 - angle1 - angle2;
    float angle4 = M_PI_2 - angle1 + angle2;
    
    NSLog(@"angle1:%f, angle2:%f, angle3:%f ", angle1, angle2, angle3);
    
    float offset1_X = cos(angle3) * circle1.radius;
    float offset1_Y = sin(angle3) * circle1.radius;
    float offset2_X = cos(angle3) * circle2.radius;
    float offset2_Y = sin(angle3) * circle2.radius;
    float offset3_X = cos(angle4) * circle1.radius;
    float offset3_Y = sin(angle4) * circle1.radius;
    float offset4_X = cos(angle4) * circle2.radius;
    float offset4_Y = sin(angle4) * circle2.radius;
    
    float p1_x = circle1_x - offset1_X;
    float p1_y = circle1_y - offset1_Y;
    float p2_x = circle2_x - offset2_X;
    float p2_y = circle2_y - offset2_Y;
    float p3_x = circle1_x + offset3_X;
    float p3_y = circle1_y + offset3_Y;
    float p4_x = circle2_x + offset4_X;
    float p4_y = circle2_y + offset4_Y;
    
    CGPoint p1 = CGPointMake(p1_x, p1_y);
    CGPoint p2 = CGPointMake(p2_x, p2_y);
    CGPoint p3 = CGPointMake(p3_x, p3_y);
    CGPoint p4 = CGPointMake(p4_x, p4_y);
    
    //画切线
//    [_path moveToPoint:p1];
//    [self drawLineStartAt:p1 EndAt:p2];
//    [_path moveToPoint:p3];
//    [self drawLineStartAt:p3 EndAt:p4];
    
    //连心线中点坐标(用来作为控制点）
//    CGPoint d_center = CGPointMake((circle1_x + circle2_x) / 2, (circle1_y + circle2_y) / 2);
    
    CGPoint p1_center_p4 = CGPointMake((p1_x + p4_x) / 2, (p1_y + p4_y) / 2);
    CGPoint p2_center_p3 = CGPointMake((p2_x + p3_x) / 2, (p2_y + p3_y) / 2);
    
    [self drawBezierCurveStartAt:p1 EndAt:p2 controlPoint:p2_center_p3];
    [self drawLineStartAt:p2 EndAt:p4];
    [self drawBezierCurveStartAt:p4 EndAt:p3 controlPoint:p1_center_p4];
    [self drawLineStartAt:p3 EndAt:p1];
    
    [_path moveToPoint:p1];
    [_path closePath];
    
    if (_isFill) {
        [_path fill];
    }else {
        [_path stroke];
    }
}

- (void)drawLineStartAt:(CGPoint)startPoint EndAt:(CGPoint)endPoint {
    [_path addLineToPoint:endPoint];
    [[UIColor blackColor] setStroke];
    [_path stroke];
}

- (void)drawBezierCurveStartAt:(CGPoint)startPoint EndAt:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint {
    [_path moveToPoint:startPoint];
    [_path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
}

#pragma mark draw circle
- (void) drawCenterCircle {
    [self drawCircle:_path circle:_centerCircle];
}

- (void) drawTouchCircle:(CGPoint)center {
    _touchCircle.centerPoint = center;
    
    [self drawCircle:_path circle:_touchCircle];
}

- (void)drawCircle:(UIBezierPath *)path circle:(Circle *)circle {
    [_path addArcWithCenter:circle.centerPoint radius:circle.radius startAngle:0 endAngle:360 clockwise:true];
    
    if (_isFill) {
        [_path fill];
    }else {
        [_path stroke];
    }
    
    
    [_path removeAllPoints];
}

#pragma mark touch event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:self];
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:self];
    
    [self setNeedsDisplay];
}

#pragma setter
- (void)setIsFill:(bool)isFill {
    _isFill = isFill;
    [self setNeedsDisplay];
}
@end
