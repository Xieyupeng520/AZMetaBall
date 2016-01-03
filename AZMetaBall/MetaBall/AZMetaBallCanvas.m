//
//  AZMetaBallCanvas.m
//  AZMetaBall
//
//  Created by 阿曌 on 16/1/2.
//  Copyright © 2016年 阿曌. All rights reserved.
//

#import "AZMetaBallCanvas.h"

@interface AZMetaBallCanvas() {
    
}

@end
@implementation AZMetaBallCanvas

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)attach:(UIView *)item {
    UIPanGestureRecognizer *drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)];
    item.userInteractionEnabled = YES;
    [item addGestureRecognizer:drag];
}

- (void)drag:(UIPanGestureRecognizer *)recognizer {
    CGPoint touchPoint = [recognizer translationInView:self];
    
    NSLog(@"touchPoint : %f,%f", touchPoint.x, touchPoint.y);
    NSLog(@"   state:%ld", (long)recognizer.state);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            [self addAzMetaBallItem:recognizer.view];
            break;
        }
        case UIGestureRecognizerStateChanged:{
            
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self removeAzMetaBallItem];
            break;
        }
        default:
            break;
    }
}

- (void)addAzMetaBallItem:(UIView *)view {
    self.azMetaBallItem = [[AZMetaBallItem alloc] initWithView:view];
}
- (void)removeAzMetaBallItem {
    self.azMetaBallItem = nil;
}
@end
