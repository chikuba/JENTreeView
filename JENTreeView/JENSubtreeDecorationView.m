//
//  JENSubtreeDecorationView.m
//
//  Created by Jennifer Nordwall on 3/8/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import "JENSubtreeDecorationView.h"
#import "JENSubtreeView.h"
#import "JENTreeView.h"

@implementation JENSubtreeDecorationView

-(id)init {
    self = [super init];
    
    if(self) {
        self.lineWidth              = 1.0;
        self.lineColor              = [UIColor blackColor];
        self.ortogonalConnection    = true;
        self.backgroundColor        = [[UIColor alloc] initWithRed:1.0
                                                             green:0.0
                                                              blue:0.0
                                                             alpha:0.0f];
    }
    
    return self;
}

#pragma mark Properties

-(void)setShowViewFrame:(BOOL)showViewFrame {
    if(_showViewFrame != showViewFrame) {
        _showViewFrame = showViewFrame;
        
        if(self.layer) {
            self.layer.borderWidth = showViewFrame ? 1.0f : 0.0f;
            self.layer.borderColor  = [UIColor redColor].CGColor;
        }
    }
}

-(void)setShowView:(BOOL)showView {
    if(_showView != showView) {
        _showView = showView;
        
        float alpha = showView ? 0.2f : 0.0f;
        self.backgroundColor = [[UIColor alloc] initWithRed:1.0
                                                      green:0.0
                                                       blue:0.0
                                                      alpha:alpha];
    }
}

- (UIBezierPath*)directConnectionsPath {
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

- (UIBezierPath*)orthogonalConnectionsPath {
    
    CGPoint rootPoint           = CGPointMake(self.invertedLayout ?
                                              self.bounds.size.width :
                                              0.0,
                                              CGRectGetMidY(self.bounds));
    
    CGPoint rootIntersection    = CGPointMake(self.invertedLayout ?
                                              self.bounds.size.width - (self.parentChildSpacing / 2) :
                                              0.0 + (self.parentChildSpacing / 2),
                                              CGRectGetMidY(self.bounds));
    
    UIBezierPath *path          = [UIBezierPath bezierPath];
    NSInteger subtreeViewCount  = 0;
    CGFloat minY                = rootPoint.y;
    CGFloat maxY                = rootPoint.y;
    
    if([self.superview isKindOfClass:[JENSubtreeView class]]) {
        for(UIView *subview in [self.superview subviews]) {
            if([subview isKindOfClass:[JENSubtreeView class]]) {
                ++subtreeViewCount;
                
                CGRect subviewBounds    = [subview bounds];
                CGPoint targetPoint     = [self convertPoint:CGPointMake(CGRectGetMidX(subviewBounds),
                                                                         CGRectGetMidY(subviewBounds))
                                                    fromView:subview];
                
                [path moveToPoint:CGPointMake(rootIntersection.x, targetPoint.y)];
                [path addLineToPoint:targetPoint];
                
                minY = MIN(minY, targetPoint.y);
                maxY = MAX(maxY, targetPoint.y);
            }
        }
    }
    
    if (subtreeViewCount) {
        [path moveToPoint:rootPoint];
        [path addLineToPoint:rootIntersection];
        [path moveToPoint:CGPointMake(rootIntersection.x, minY - (0.5 * self.lineWidth))];
        [path addLineToPoint:CGPointMake(rootIntersection.x, maxY + (0.5 * self.lineWidth))];
    }
    
    return path;
}

- (void)drawRect:(CGRect)dirtyRect {
    UIBezierPath *path = self.ortogonalConnection ?
                            [self orthogonalConnectionsPath] :
                            [self directConnectionsPath];

    [self.lineColor set];
    path.lineWidth = self.lineWidth;
    [path stroke];
}

@end
