//
//  GLSetGestureLockViewController.m
//  GestureLock
//
//  Created by Zhu Boxing on 14-4-13.
//  Copyright (c) 2014年 ZhuBoxing. All rights reserved.
//

#import "GLSetGestureLockViewController.h"

@interface GLSetGestureLockViewController ()
{
    NSString *lockKey;
}
@end

@implementation GLSetGestureLockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置解锁图案";
    if([self respondsToSelector:@selector(edgesForExtendedLayout)]) self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"绘制解锁图案";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tipLabel];
    
    CGRect frameRect = self.view.bounds;
    frameRect.size.height = frameRect.size.width;
    GLGestureLockView *Lview = [[GLGestureLockView alloc] initWithFrame:frameRect callBack:^(NSString *key) {
        if (lockKey) {
            if ([lockKey isEqualToString:key]) {
                tipLabel.textColor = [UIColor whiteColor];
                tipLabel.text = @"设置成功";
                [[NSUserDefaults standardUserDefaults] setObject:key forKey:@"lockKey"];
                [self performSelector:@selector(pushBack) withObject:nil afterDelay:1.0];
            } else {
                tipLabel.textColor = [UIColor redColor];
                tipLabel.text = @"与上次绘制不一致，请重新绘制";
            }
        } else {
            lockKey = key;
            tipLabel.textColor = [UIColor whiteColor];
            tipLabel.text = @"再次绘制解锁图案";
        }
    }];
    Lview.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:Lview];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self.view, Lview, tipLabel);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tipLabel(30)][Lview]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Lview]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tipLabel]|" options:0 metrics:nil views:views]];
}

- (void)pushBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
