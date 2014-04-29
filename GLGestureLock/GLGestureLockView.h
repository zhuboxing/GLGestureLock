//
//  GLGestureLockView.h
//  GestureLock
//
//  Created by Zhu Boxing on 14-3-18.
//  Copyright (c) 2014年 ZhuBoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^GLGestureCallBack)(NSString *key);

@interface GLGestureLockView : UIView
@property (nonatomic, assign) GLGestureCallBack callBack;

- (id)initWithFrame:(CGRect)frame callBack:(GLGestureCallBack)cb;
@end
