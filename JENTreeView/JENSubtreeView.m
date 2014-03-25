//
//  JENSubtreeView.m
//
//  Created by Jennifer Nordwall on 3/8/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import "JENSubtreeView.h"
#import "JENTreeViewModelNode.h"
#import "JENSubtreeDecorationView.h"
#import "JENNodeView.h"

@interface JENSubtreeView ()

@property (nonatomic, strong) JENNodeView *nodeView;
@property (nonatomic, strong) id<JENTreeViewModelNode> modelNode;
@property (nonatomic, strong) JENSubtreeDecorationView *decorationsView;

@end

@implementation JENSubtreeView

-(id)initWithModelNode:(id<JENTreeViewModelNode>)modelNode {
    NSParameterAssert(modelNode);
    
    self = [super initWithFrame:CGRectMake(10, 10, 100, 25)];
    
    if(self) {
        self.modelNode              = modelNode;
        self.autoresizesSubviews    = FALSE;
        self.parentChildSpacing     = 40.0;
        self.siblingSpacing         = 10.0;
        
        self.nodeView               = [[JENNodeView alloc]
                                       initWithFrame:CGRectMake(0, 0, 160, 30)];
        self.nodeView.name          = modelNode.name;
        
        self.decorationsView        = [[JENSubtreeDecorationView alloc] init];

        [self addSubview:self.nodeView];
        [self addSubview:self.decorationsView];
    }
    return self;
}

#pragma mark Properties

-(void)setInvertedLayout:(BOOL)invertedLayout {
    if(_invertedLayout != invertedLayout) {
        _invertedLayout = invertedLayout;
        
        for(UIView *subview in self.subviews) {
            if([subview isKindOfClass:[JENSubtreeView class]]) {
                ((JENSubtreeView*)subview).invertedLayout = invertedLayout;
            }
        }
    }
}

-(void)setAlignChildren:(BOOL)alignChildren {
    if(_alignChildren != alignChildren) {
        _alignChildren = alignChildren;
        
        for(UIView *subview in self.subviews) {
            if([subview isKindOfClass:[JENSubtreeView class]]) {
                ((JENSubtreeView*)subview).alignChildren = alignChildren;
            }
        }
    }
}

-(void)setOrtogonalConnection:(BOOL)ortogonalConnection {
    if(_ortogonalConnection != ortogonalConnection) {
        _ortogonalConnection = ortogonalConnection;
        
        self.decorationsView.ortogonalConnection = ortogonalConnection;
        
        for(UIView *subview in self.subviews) {
            if([subview isKindOfClass:[JENSubtreeView class]]) {
                ((JENSubtreeView*)subview).ortogonalConnection = ortogonalConnection;
            }
        }
    }
}

-(void)setDecorationLineColor:(UIColor *)decorationLineColor {
    if(_decorationLineColor != decorationLineColor) {
        _decorationLineColor = decorationLineColor;
        
        self.decorationsView.lineColor = decorationLineColor;
        
        for(UIView *subview in self.subviews) {
            if([subview isKindOfClass:[JENSubtreeView class]]) {
                ((JENSubtreeView*)subview).decorationLineColor = decorationLineColor;
            }
        }
    }
}

-(void)setNodeBackgroundColor:(UIColor *)nodeBackgroundColor {
    if(_nodeBackgroundColor != nodeBackgroundColor) {
        _nodeBackgroundColor = nodeBackgroundColor;
        
        self.nodeView.backgroundColor = nodeBackgroundColor;
        
        for(UIView *subview in self.subviews) {
            if([subview isKindOfClass:[JENSubtreeView class]]) {
                ((JENSubtreeView*)subview).nodeBackgroundColor = nodeBackgroundColor;
            }
        }
    }
}

-(void)setShowView:(BOOL)showView {
    if(_showView != showView) {
        _showView = showView;
        
        float alpha = showView ? 0.2f : 0.0f;
        self.backgroundColor = [[UIColor alloc] initWithRed:1.0
                                                      green:1.0
                                                       blue:1.0
                                                      alpha:alpha];
        
        for(UIView *subview in self.subviews) {
            if([subview isKindOfClass:[JENSubtreeView class]]) {
                ((JENSubtreeView*)subview).showView = showView;
            }
        }
    }
}

-(void)setShowViewFrame:(BOOL)showViewFrame {
    if(_showViewFrame != showViewFrame) {
        _showViewFrame = showViewFrame;
        
        if(self.layer) {
            self.layer.borderWidth = showViewFrame ? 1.0f : 0.0f;
            self.layer.borderColor  = [UIColor blackColor].CGColor;
        }
        
        for(UIView *subview in self.subviews) {
            if([subview isKindOfClass:[JENSubtreeView class]]) {
                ((JENSubtreeView*)subview).showViewFrame = showViewFrame;
            }
        }
    }
}

-(void)setShowDecorationView:(BOOL)showDecorationView {
    if(_showDecorationView != showDecorationView) {
        _showDecorationView = showDecorationView;
        
        self.decorationsView.showView = showDecorationView;
        
        for(UIView *subview in self.subviews) {
            if([subview isKindOfClass:[JENSubtreeView class]]) {
                ((JENSubtreeView*)subview).showDecorationView = showDecorationView;
            }
        }
    }
}

-(void)setShowDecorationViewFrame:(BOOL)showDecorationViewFrame {
    if(_showDecorationViewFrame != showDecorationViewFrame) {
        _showDecorationViewFrame = showDecorationViewFrame;
        
        self.decorationsView.showViewFrame = showDecorationViewFrame;
        
        for(UIView *subview in self.subviews) {
            if([subview isKindOfClass:[JENSubtreeView class]]) {
                ((JENSubtreeView*)subview).showDecorationViewFrame = showDecorationViewFrame;
            }
        }
    }
}

#pragma mark Layout

-(CGSize)layoutGraph {
    NSArray *subviews                   = self.subviews;
    CGFloat maxWidth                    = 0.0;
    CGFloat minWidth                    = CGFLOAT_MAX;
    NSUInteger subtreeViewCount         = 0;
    CGSize nodeViewSize                 = self.nodeView.frame.size;
    CGPoint subtreeOrigion              = CGPointMake(0.0, 0.0);
    NSMutableDictionary *subViewSizes   = [[NSMutableDictionary alloc] init];
    
    // get max/minWidth of the subviews that we will use later on
    for (UIView *subview in subviews) {
        if([subview isKindOfClass:[JENSubtreeView class]]) {
            CGSize subViewSize = [((JENSubtreeView*)subview) layoutGraph];
            
            maxWidth = MAX(maxWidth, subViewSize.width);
            minWidth = MIN(minWidth, subViewSize.width);
            
            [subViewSizes setObject:[NSValue valueWithCGSize:subViewSize]
                             forKey:@(subview.hash)];
        }
    }

    // walk through subviews and position them
    for (UIView *subview in subviews.reverseObjectEnumerator) {
        if([subview isKindOfClass:[JENSubtreeView class]]) {
            subtreeViewCount++;
            
            CGSize subtreeViewSize = [subViewSizes[@(subview.hash)] CGSizeValue];
            
            if(self.invertedLayout) {
                subtreeOrigion.x = 0.0;
            } else subtreeOrigion.x = nodeViewSize.width + self.parentChildSpacing;

            if((self.invertedLayout && !self.alignChildren) ||
               (!self.invertedLayout && self.alignChildren)) {
                subtreeOrigion.x += (maxWidth - subtreeViewSize.width);
            }

            CGRect frame    = subview.frame;
            frame.origin    = subtreeOrigion;
            subview.frame   = frame;
            
            // for next run
            subtreeOrigion.y += subtreeViewSize.height + self.siblingSpacing;
        }
    }
    
    CGSize selfTargetSize;
    CGRect nodeViewFrame = self.nodeView.frame;
    
    if(subtreeViewCount > 0) {
        // *** NODE VIEW *** //
        selfTargetSize  = CGSizeMake(nodeViewSize.width + self.parentChildSpacing + maxWidth,
                                     MAX(subtreeOrigion.y - self.siblingSpacing,
                                         nodeViewSize.height));
    
        CGRect frame    = self.frame;
        frame.size      = selfTargetSize;
        self.frame      = frame;
        
        nodeViewFrame.origin = CGPointMake(self.invertedLayout ?
                                           maxWidth + self.parentChildSpacing : 0.0,
                                           0.5 * (selfTargetSize.height - nodeViewSize.height));
        self.nodeView.frame  = nodeViewFrame;
        
        // *** DECORATION VIEW *** //
        CGFloat decorationViewWidth = self.parentChildSpacing;
        CGFloat decorationViewX     = nodeViewSize.width;
        
        if(self.invertedLayout) {
            decorationViewX = self.alignChildren ? minWidth : maxWidth;
        }
        
        if(self.alignChildren) {
            decorationViewWidth = self.frame.size.width - nodeViewSize.width - minWidth;
        }
        
        CGRect decorationsViewFrame = CGRectMake(decorationViewX,
                                                 0.0,
                                                 decorationViewWidth,
                                                 selfTargetSize.height);
        self.decorationsView.frame  = decorationsViewFrame;
        
        self.decorationsView.hidden                 = false;
        self.decorationsView.parentChildSpacing     = self.parentChildSpacing;
        self.decorationsView.invertedLayout         = self.invertedLayout;
        self.decorationsView.ortogonalConnection    = self.ortogonalConnection;
        
        [self.decorationsView setNeedsDisplay];
        
    } else { // leaf node
        // *** NODE VIEW *** //
        selfTargetSize          = nodeViewSize;
        
        nodeViewFrame.origin    = CGPointMake(self.invertedLayout ?
                                              maxWidth + self.parentChildSpacing : 0.0,
                                              0.0);
        self.frame              = nodeViewFrame;
    }
    
    return selfTargetSize;
}

@end
