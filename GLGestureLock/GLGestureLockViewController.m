//
//  GLGestureLockViewController.m
//  GestureLock
//
//  Created by Zhu Boxing on 14-3-18.
//  Copyright (c) 2014年 ZhuBoxing. All rights reserved.
//

#import "GLGestureLockViewController.h"

@interface GLGestureLockViewController ()
{
}

@end

@implementation GLGestureLockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    
//    GLGestureLockView *view = [[GLGestureLockView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:view];
    
    CGRect frameRect = self.view.frame;
    frameRect.size.height = frameRect.size.width;
    GLGestureLockView *Lview = [[GLGestureLockView alloc] initWithFrame:frameRect];
    [self.view addSubview:Lview];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self.view, Lview);
    Lview.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[Lview]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Lview]|" options:0 metrics:nil views:views]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
