//
//  ViewController.m
//  CircleProgress
//
//  Created by 葛大婷 on 2020/2/19.
//  Copyright © 2020 葛大婷. All rights reserved.
//

#import "ViewController.h"
#import "WHCircleProgress.h"
#import "ZSGetDeviceInformation.h"

@interface ViewController ()<WHCircleProgressDelegate>{
    
}
@property (nonatomic, strong) WHCircleProgress *circleProgress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HomePageBack.png"]];
    imageView.frame = self.view.frame;
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 52, CGRectGetWidth(self.view.frame), 20)];
    label.textColor = UIColor.whiteColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"你的信用评分";
    [self.view addSubview:label];
    
    CGFloat padding = 45;
    NSString *phoneModel = [ZSGetDeviceInformation deviceModelName];
    if ([phoneModel isEqualToString:@"iPhone 5S"] || [phoneModel isEqualToString:@"iPhone 5"]) {
        padding = 25;
    }else if ([phoneModel rangeOfString:@"iPad"].length > 0){
        padding = 15;
    }
    
    WHCircleProgress *circleProgress = [[WHCircleProgress alloc] initWithFrame:CGRectMake(padding, 80, CGRectGetWidth(self.view.frame) - padding * 2, CGRectGetWidth(self.view.frame) - padding * 2) currentScore:0 highestScore:1000];
    circleProgress.progressWidth = 8;
//    circleProgress.bottomColor = [CommonHelper colorWithHex:0xfde090];
    circleProgress.bottomColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    circleProgress.topColor = [UIColor whiteColor];
    circleProgress.topDotColor = [UIColor clearColor];
    circleProgress.isCertified = NO;
    circleProgress.delegate = self;
    circleProgress.highestScore = 100;
    circleProgress.currentScore = 0;
    
    [self.view addSubview:circleProgress];
    self.circleProgress = circleProgress;
    
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(100, CGRectGetHeight(self.view.frame) - 100, CGRectGetWidth(self.view.frame) - 200, 35)];
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    // Do any additional setup after loading the view.
}

-(void)sliderChange:(UISlider*)slider{
    self.circleProgress.currentScore = slider.value;
    if (slider.value == 0) {
        self.circleProgress.isCertified = NO;
        self.circleProgress.topDotColor = [UIColor clearColor];
        self.circleProgress.certifiedName = @"开始认证";
    }else if (slider.value < slider.maximumValue){
        self.circleProgress.isCertified = NO;
        self.circleProgress.certifiedName = @"继续认证";
        self.circleProgress.topDotColor = [UIColor whiteColor];
        
    }else{
        self.circleProgress.isCertified = YES;
    }
    
}


#pragma mark - WHCircleProgressDelegate
-(void)startCertificationFunction{
    
}

@end
