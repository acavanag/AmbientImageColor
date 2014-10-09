//
//  ViewController.m
//  images
//
//  Created by Andrew Cavanagh on 10/9/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import "ViewController.h"
#import "ImageTest.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *colorView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    self.colorView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.colorView];
    
    UIImage *image = [UIImage imageNamed:@"sunset1.jpg"];
    UIColor *color = [ImageTest averageColorForImage:image];
    
    NSLog(@"%@", [color description]);
    
    self.colorView.backgroundColor = color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
