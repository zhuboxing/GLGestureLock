//
//  GLGestureLockView.m
//  GestureLock
//
//  Created by Zhu Boxing on 14-3-18.
//  Copyright (c) 2014年 ZhuBoxing. All rights reserved.
//

#import "GLGestureLockView.h"
#define RADIUS  30
#define NUMBER  3

@interface GLGestureLockView()
{
    CGPoint startPoint;
    CGPoint endPoint;
    CGPoint overPoint;
    
    NSMutableArray *pointArray;
    NSString *key;
}

@end

@implementation GLGestureLockView
@synthesize callBack;

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame callBack:nil];
}

- (id)initWithFrame:(CGRect)frame callBack:(GLGestureCallBack)cb
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        float marginTop = (self.frame.size.height - self.frame.size.width) / 2 + RADIUS;
        float xOffset = self.frame.size.width / NUMBER;
        for (int i = 0; i < NUMBER; i++) {
            for (int j = 0; j < NUMBER; j ++) {
                UIView *arcView = [self drawArc:CGPointMake((i + 0.5) * xOffset, marginTop + j * xOffset) round:RADIUS];
                arcView.tag = 10 * (i + 1) + (j + 1);
                [self addSubview:arcView];
            }
        }
    }
    callBack = cb;
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self drawLineWithColor:[UIColor colorWithWhite:1 alpha:0.8] width:5.0f];
    [self drawArcWithColor:[UIColor colorWithWhite:1 alpha:0.5] radius:5];
}

- (UIView *)drawArc:(CGPoint)center round:(CGFloat)round
{
    UIView *lockKeyView = [[UIView alloc] init];
    [lockKeyView.layer setMasksToBounds:YES];
    [lockKeyView.layer setCornerRadius:round];
    [lockKeyView.layer setBorderColor:[UIColor colorWithWhite:1 alpha:0.5].CGColor];
    [lockKeyView.layer setBorderWidth:1.0f];
    [lockKeyView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [lockKeyView setFrame:CGRectMake(center.x - round, center.y - round, 2 * round, 2 * round)];
    [lockKeyView setUserInteractionEnabled:NO];
    return lockKeyView;
}

#pragma mark - Touch Delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    key = @"";
    pointArray = [[NSMutableArray alloc] init];
    
    UITouch *touch = [touches anyObject];
    UIView *startView = [self moveOver:[touch locationInView:self]];
    startPoint = startView.center;
    [self addPoint:startPoint withTag:startView.tag];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    endPoint = [touch locationInView:self];
    UIView *overView = [self moveOver:endPoint];
    overPoint = overView ? overView.center : CGPointZero;
    [self addPoint:overPoint withTag:overView.tag];
    if (CGPointEqualToPoint(startPoint, CGPointZero)) return;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
    NSLog(@">>>>%@", key);
    if (callBack) callBack(key);
    [self reloadView];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touches Canelled");
    [self reloadView];
}

#pragma mark - handler
- (UIView *)moveOver:(CGPoint)currPoint
{
    UIView *oView = nil;
    for (UIView *arc in self.subviews) {
        if (arc.tag > 0) {
            CGFloat xDist = (currPoint.x - arc.center.x);
            CGFloat yDist = (currPoint.y - arc.center.y);
            if (sqrt((xDist * xDist) + (yDist * yDist)) <= RADIUS) {
                oView = arc;
            }
        }
    }
    return oView;
}

- (void)addPoint:(CGPoint)point withTag:(NSInteger)tag
{
    if (!CGPointEqualToPoint(overPoint, CGPointZero)) {
        NSValue *pointValue = [NSValue valueWithCGPoint:overPoint];
        if ([pointArray indexOfObject:pointValue] == NSNotFound) {
            int intTag = (int)tag;
            if (key.length > 0) {
                int currentKey = [[key substringFromIndex:key.length - 2] intValue];
                int currentKeyX = currentKey / 10;
                int currentKeyY = currentKey % 10;
                int intTagX = intTag / 10;
                int intTagY = intTag % 10;
                if (currentKeyX == intTagX) {
                    int offsety = currentKeyY - intTagY;
                    if (fabs(offsety) > 1) {
                        for (int i = 1; i < fabs(offsety); i++) {
                            int addTag = intTag + (offsety / fabs(offsety));
                            UIView *addView = [self viewWithTag:addTag];
                            NSValue *pointValue = [NSValue valueWithCGPoint:addView.center];
                            if ([pointArray indexOfObject:pointValue] == NSNotFound) {
                                [pointArray addObject:pointValue];
                                key = [key stringByAppendingFormat:@"%d", addTag];
                            }
                        }
                    }
                } else if (currentKeyY == intTagY) {
                    int offsetx = currentKeyX - intTagX;
                    if (fabs(offsetx) > 1) {
                        for (int i = 1; i < fabs(offsetx); i++) {
                            int addTag = intTag + (10 * offsetx / fabs(offsetx));
                            UIView *addView = [self viewWithTag:addTag];
                            NSValue *pointValue = [NSValue valueWithCGPoint:addView.center];
                            if ([pointArray indexOfObject:pointValue] == NSNotFound) {
                                [pointArray addObject:pointValue];
                                key = [key stringByAppendingFormat:@"%d", addTag];
                            }
                        }
                    }
                } else if (currentKey / 10 + intTag / 10 == currentKey % 10 + intTag % 10) {
                    int offsetx = currentKeyX - intTagX;
                    int offsety = currentKeyY - intTagY;
                    if (fabs(offsetx) > 1) {
                        for (int i = 1; i < fabs(offsetx); i++) {
                            int addTag = 10 * (intTagX + i * offsetx / fabs(offsetx)) + intTagY + (i * offsety / fabs(offsety));
                            UIView *addView = [self viewWithTag:addTag];
                            NSValue *pointValue = [NSValue valueWithCGPoint:addView.center];
                            if ([pointArray indexOfObject:pointValue] == NSNotFound) {
                                [pointArray addObject:pointValue];
                                key = [key stringByAppendingFormat:@"%d", addTag];
                            }
                        }
                    }
                }
            }
            [pointArray addObject:pointValue];
            key = [key stringByAppendingFormat:@"%d", intTag];
            startPoint = overPoint;
        }
    }
}

- (void)reloadView
{
    startPoint = CGPointZero;
    endPoint = CGPointZero;
    overPoint = CGPointZero;
    [pointArray removeAllObjects];
    [self setNeedsDisplay];
}

#pragma mark - Draw Line
- (void)drawLineWithColor:(UIColor *)color width:(CGFloat)width
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextBeginPath(context);
    
    for (int i = 0; i < ((int)pointArray.count - 1); i++) {
        NSValue *startPointValue = pointArray[i];
        NSValue *endPointValue = pointArray[i + 1];
        CGContextMoveToPoint(context, startPointValue.CGPointValue.x, startPointValue.CGPointValue.y);
        CGContextAddLineToPoint(context, endPointValue.CGPointValue.x, endPointValue.CGPointValue.y);;
    }
    
    if (!CGPointEqualToPoint(startPoint, endPoint)) {
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    }
    
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, width);
    
    CGContextStrokePath(context);
}

- (void)drawArcWithColor:(UIColor *)color radius:(CGFloat)radius
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (NSValue *pointValue in pointArray) {
        CGContextAddEllipseInRect(context, CGRectMake(pointValue.CGPointValue.x - radius, pointValue.CGPointValue.y - radius, 2 * radius, 2 * radius));
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillPath(context);
        
        CGContextAddEllipseInRect(context, CGRectMake(pointValue.CGPointValue.x - radius, pointValue.CGPointValue.y - radius, 2 * radius, 2 * radius));
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextStrokePath(context);
    }
}

@end
