//
//  JENTreeView.h
//
//  Created by Jennifer Nordwall on 3/8/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JENTreeViewModelNode.h"

@interface JENTreeView : UIScrollView

@property (nonatomic, retain) id<JENTreeViewModelNode> rootNode;

// subview properties 
@property (nonatomic, assign) BOOL invertedLayout;
@property (nonatomic, assign) BOOL alignChildren;
@property (nonatomic, assign) BOOL ortogonalConnection;

@property (nonatomic, assign) CGFloat parentChildSpacing;
@property (nonatomic, assign) CGFloat siblingSpacing;

@property (nonatomic, strong) UIColor *nodeBackgroundColor;
@property (nonatomic, strong) UIColor *decorationLineColor;

-(void)layoutGraph;

// debugging options
@property (nonatomic, assign) BOOL showSubviews;
@property (nonatomic, assign) BOOL showSubviewFrames;
@property (nonatomic, assign) BOOL showDecorationViewFrames;
@property (nonatomic, assign) BOOL showDecorationViews;

@end
