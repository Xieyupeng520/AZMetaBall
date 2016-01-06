//
//  ViewController.m
//  AZMetaBall
//
//  Created by 阿曌 on 15/12/15.
//  Copyright © 2015年 阿曌. All rights reserved.
//

#import "DetailViewController.h"
#import "AZMetaBall.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet AZMetaBall *azMetaBall;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)onProgressChanged:(id)sender {
    UISlider *slider = sender;
    float value = slider.value;
    NSLog(@"progress:%f", value);
    
    switch (slider.tag) {
        case 11:{
            float r = RADIUS;
            [self.azMetaBall changeCenterCircleRadiusTo:r * value];
            break;
        }
        case 12:{
            float r = RADIUS;
            [self.azMetaBall changeTouchCircleRadiusTo:r * value];
            break;
        }
        default:
            break;
    }
}
- (IBAction)fillOrStroke:(id)sender {
        self.azMetaBall.isFill = !self.azMetaBall.isFill;

}

@end
