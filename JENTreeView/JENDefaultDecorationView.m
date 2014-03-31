//
//  JENSubtreeDecorationView.m
//
//  Created by Jennifer Nordwall on 3/8/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import "JENDefaultDecorationView.h"
#import "JENSubtreeView.h"

@implementation JENDefaultDecorationView

-(id)init {
    self = [super init];
    
    if(self) {
        self.backgroundColor = [[UIColor alloc] initWithRed:1.0
                                                      green:0.0
                                                       blue:0.0
                                                      alpha:0.0f];
    }
    
    return self;
}

- (UIBezierPath*)connectionPath {
    CGPoint rootPoint   = CGPointMake(self.invertedLayout ?
                                      self.bounds.size.width :
                                      0.0,
                                      CGRectGetMidY(self.bounds));
    
    UIBezierPath *path  = [UIBezierPath bezierPath];
    
    if([self.superview isKindOfClass:[JENSubtreeView class]]) {
        for(UIView *subview in [self.superview subviews]) {
            if([subview isKindOfClass:[JENSubtreeView class]]) {
                CGPoint targetPoint = [self convertPoint:CGPointMake(self.invertedLayout ?
                                                                     subview.bounds.size.width :
                                                                     subview.bounds.origin.x,
                                                                     CGRectGetMidY(subview.bounds))
                                                fromView:subview];
                
                [path moveToPoint:rootPoint];
                [path addLineToPoint:targetPoint];
            }
        }
    }
    return path;
}


- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [self connectionPath];

    [[UIColor blackColor] set];
    path.lineWidth = 1.0;
    [path stroke];
}

@end
