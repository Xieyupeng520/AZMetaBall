//
//  AZMetaBallCanvas.m
//  AZMetaBall
//
//  Created by 阿曌 on 16/1/2.
//  Copyright © 2016年 阿曌. All rights reserved.
//

#import "AZMetaBallCanvas.h"

#define kMax_Distance 75

@interface AZMetaBallCanvas() {
    UIBezierPath *_path; //画线
    
    CGPoint _touchPoint; //触摸点
    
    bool _isTouch;   //是否触摸
    
    float _distance; //连心线长度
}

@end
@implementation AZMetaBallCanvas


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    _path = [[UIBezierPath alloc] init];
    
    [self caculateDistance: self.azMetaBallItem.centerCircle Circle2:self.azMetaBallItem.touchCircle];
    
    if (!_isTouch || _distance > kMax_Distance) {
        return;
    }
    
    [self drawBezierCurveWithCircle1:self.azMetaBallItem.centerCircle Circle2:self.azMetaBallItem.touchCircle];
    
    [self drawCenterCircle];
    
    [self drawTouchCircle];
}

- (void)reset {
    _isTouch = false;
    [self removeAzMetaBallItem];
    _distance = 0;
}

- (void)attach:(UIView *)item {
    UIPanGestureRecognizer *drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)];
    item.userInteractionEnabled = YES;
    [item addGestureRecognizer:drag];
}

- (void)drag:(UIPanGestureRecognizer *)recognizer {
    _touchPoint = [recognizer locationInView:self];
    
    UIView *touchView = recognizer.view;
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            [self addAzMetaBallItem:touchView];
            _isTouch = true;
            recognizer.view.hidden = YES;
            break;
        }
        case UIGestureRecognizerStateChanged:{
            [self resetTouchCenter:_touchPoint];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            
            if (_distance > kMax_Distance) {
                [self explosion];
            } else {
                recognizer.view.hidden = NO;
            }
            
            [self reset];
            break;
        }
        default:
            break;
    }
    
    [self setNeedsDisplay]; //重绘
}

- (void)addAzMetaBallItem:(UIView *)view {
    self.azMetaBallItem = [[AZMetaBallItem alloc] initWithView:view];
    
    [self addSubview:self.azMetaBallItem.view];
}
- (void)removeAzMetaBallItem {
    [self.azMetaBallItem.view removeFromSuperview];
    self.azMetaBallItem = nil;
}

#pragma mark draw circle
- (void) drawCenterCircle {
    
    self.azMetaBallItem.centerCircle.radius = self.azMetaBallItem.centerCircle.orignRadius - _distance / 15;
    
    [self drawCircle:_path circle:self.azMetaBallItem.centerCircle];
}

- (void) drawTouchCircle {
    
    self.azMetaBallItem.touchCircle.radius = self.azMetaBallItem.touchCircle.orignRadius - _distance / 30;
    
    [self drawCircle:_path circle:self.azMetaBallItem.touchCircle];
}

- (void)drawCircle:(UIBezierPath *)path circle:(Circle *)circle {
    [_path addArcWithCenter:circle.centerPoint radius:circle.radius startAngle:0 endAngle:360 clockwise:true];
    
    [circle.color setFill];
    [_path fill];
    
    [_path removeAllPoints];
}

#pragma reset touch center point of touch circle and touch view

-(void)resetTouchCenter:(CGPoint)center {
    self.azMetaBallItem.touchCircle.centerPoint = center;
    self.azMetaBallItem.view.center = center;
}

#pragma caculate distance of two circle
- (void)caculateDistance:(Circle *)circle1 Circle2:(Circle *)circle2 {
    float circle1_x = circle1.centerPoint.x;
    float circle1_y = circle1.centerPoint.y;
    float circle2_x = circle2.centerPoint.x;
    float circle2_y = circle2.centerPoint.y;
    
    //连心线的长度
    _distance = sqrt(powf(circle1_x - circle2_x, 2) + powf(circle1_y - circle2_y, 2));
    //画连心线
    //    [self drawLineStartAt:circle1.centerPoint EndAt:circle2.centerPoint];
    NSLog(@"连心线长度为：%f", _distance);
}

#pragma mark draw curve
- (void)drawBezierCurveWithCircle1:(Circle *)circle1 Circle2:(Circle *)circle2 {
    float circle1_x = circle1.centerPoint.x;
    float circle1_y = circle1.centerPoint.y;
    float circle2_x = circle2.centerPoint.x;
    float circle2_y = circle2.centerPoint.y;
    
    //连心线x轴的夹角
    float angle1 = atan((circle2_y - circle1_y) / (circle1_x - circle2_x));
    //连心线和公切线的夹角
    float angle2 = asin((circle1.radius - circle2.radius) / _distance);
    //切点到圆心和x轴的夹角
    float angle3 = M_PI_2 - angle1 - angle2;
    float angle4 = M_PI_2 - angle1 + angle2;
    
//    NSLog(@"angle1:%f, angle2:%f, angle3:%f ", angle1, angle2, angle3);
    
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
    
    //TX设计师描述的控制点算法
    CGPoint p1_center_p4 = CGPointMake((p1_x + p4_x) / 2, (p1_y + p4_y) / 2);
    CGPoint p2_center_p3 = CGPointMake((p2_x + p3_x) / 2, (p2_y + p3_y) / 2);
    
    [self drawBezierCurveStartAt:p1 EndAt:p2 controlPoint:p2_center_p3];
    [self drawLineStartAt:p2 EndAt:p4];
    [self drawBezierCurveStartAt:p4 EndAt:p3 controlPoint:p1_center_p4];
    [self drawLineStartAt:p3 EndAt:p1];
    
    [_path moveToPoint:p1];
    [_path closePath];
    
    [_path fill];
}

- (void)drawLineStartAt:(CGPoint)startPoint EndAt:(CGPoint)endPoint {
    [_path addLineToPoint:endPoint];
}

- (void)drawBezierCurveStartAt:(CGPoint)startPoint EndAt:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint {
    [_path moveToPoint:startPoint];
    [_path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
}

#pragma explosion animation
- (void)explosion {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 1; i < 6; i++) {
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"id_%d", i] ofType:@"png"]];
        [array addObject:image];
    }
    
    UIImageView *iV = [[UIImageView alloc] init];
    iV.frame = CGRectMake(0, 0, 34, 34);
    iV.center = _touchPoint;
    
    iV.animationImages = array;
    [iV setAnimationDuration:0.5];
    [iV setAnimationRepeatCount:1];
    [iV startAnimating];
    [self addSubview:iV];
}
@end
