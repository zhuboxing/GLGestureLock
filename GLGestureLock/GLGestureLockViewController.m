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
    int inputCount;
}

@end

@implementation GLGestureLockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    inputCount = 5;
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBarHidden = YES;
    if([self respondsToSelector:@selector(edgesForExtendedLayout)]) self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"输入解锁图案";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tipLabel];
    
    CGRect frameRect = self.view.bounds;
    frameRect.size.height = frameRect.size.width;
    GLGestureLockView *Lview = [[GLGestureLockView alloc] initWithFrame:frameRect callBack:^(NSString *key) {
        if ([key isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"lockKey"]]) {
            tipLabel.text = @"输入正确";
            tipLabel.textColor = [UIColor whiteColor];
            [self dismissViewControllerAnimated:YES completion:^{}];
        } else {
            inputCount--;
            tipLabel.text = [NSString stringWithFormat:@"输入错误，还可以输入%d次", inputCount];
            tipLabel.textColor = [UIColor redColor];
        }
    }];
    Lview.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:Lview];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self.view, Lview, tipLabel);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tipLabel(30)][Lview]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Lview]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tipLabel]|" options:0 metrics:nil views:views]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
