//
//  AZMetaBallItem.m
//  AZMetaBall
//
//  Created by 阿曌 on 16/1/2.
//  Copyright © 2016年 阿曌. All rights reserved.
//

#import "AZMetaBallItem.h"

@implementation AZMetaBallItem

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if(self) {
        self.view = view;
        
    
        float w = view.frame.size.width;
        float h = view.frame.size.height;
        
        self.circle = [Circle initWithcenterPoint:view.center radius:MIN(w, h)];
    }
    return self;
}


@end
