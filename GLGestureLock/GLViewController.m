//
//  GLViewController.m
//  GLGestureLock
//
//  Created by Zhu Boxing on 14-4-29.
//  Copyright (c) 2014年 ZhuBoxing. All rights reserved.
//

#import "GLViewController.h"
#import "GLGestureLockViewController.h"
#import "GLSetGestureLockViewController.h"

@interface GLViewController ()

@end

@implementation GLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)]) self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor blackColor];
//
//    CGRect frameRect = self.view.frame;
//    frameRect.size.height = frameRect.size.width;
//    GLGestureLockView *Lview = [[GLGestureLockView alloc] initWithFrame:frameRect callBack:^(NSString *key) {
//    }];
//    [self.view addSubview:Lview];
//    
//    NSDictionary *views = NSDictionaryOfVariableBindings(self.view, Lview);
//    Lview.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[Lview]|" options:0 metrics:nil views:views]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Lview]|" options:0 metrics:nil views:views]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"锁定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(lockClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:@"设置" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(setClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self.view, button, button2);
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button(30)]-10-[button2(30)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button(100)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button2(100)]" options:0 metrics:nil views:views]];
    self.view.clipsToBounds = YES;
}

- (void)lockClick:(id)sender
{
    GLGestureLockViewController *GlVc = [[GLGestureLockViewController alloc] init];
    [self.navigationController presentViewController:GlVc animated:YES completion:^{ }];
}

- (void)setClick:(id)sender
{
    GLSetGestureLockViewController *setVc = [[GLSetGestureLockViewController alloc] init];
    [self.navigationController pushViewController:setVc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
