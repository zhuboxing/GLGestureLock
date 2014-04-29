//
//  GLViewController.m
//  GLGestureLock
//
//  Created by Zhu Boxing on 14-4-29.
//  Copyright (c) 2014年 ZhuBoxing. All rights reserved.
//

#import "GLViewController.h"
#import "GLGestureLockViewController.h"

@interface GLViewController ()

@end

@implementation GLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super viewDidLoad];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)]) self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect frameRect = self.view.bounds;
    frameRect.size.height = frameRect.size.width;
    GLGestureLockView *Lview = [[GLGestureLockView alloc] initWithFrame:frameRect callBack:^(NSString *key) {
        
    }];
    [self.view addSubview:Lview];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self.view, Lview);
    Lview.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[Lview]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Lview]|" options:0 metrics:nil views:views]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"锁定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(lockClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //    NSDictionary *views = NSDictionaryOfVariableBindings(self.view, button);
    //    button.translatesAutoresizingMaskIntoConstraints = NO;
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[button]|" options:0 metrics:nil views:views]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button]|" options:0 metrics:nil views:views]];
}

- (void)lockClick:(id)sender
{
    GLGestureLockViewController *GlVc = [[GLGestureLockViewController alloc] init];
    [self.navigationController presentViewController:GlVc animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
