//
//  JENSubtreeView.h
//
//  Created by Jennifer Nordwall on 3/8/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JENTreeViewModelNode.h"

@interface JENSubtreeView : UIView

@property (nonatomic, assign) BOOL invertedLayout;
@property (nonatomic, assign) BOOL alignChildren;
@property (nonatomic, assign) BOOL ortogonalConnection;

@property (nonatomic, assign) CGFloat parentChildSpacing;
@property (nonatomic, assign) CGFloat siblingSpacing;

@property (nonatomic, strong) UIColor *nodeBackgroundColor;
@property (nonatomic, strong) UIColor *decorationLineColor;

-initWithModelNode:(id<JENTreeViewModelNode>)modelNode;
-(CGSize)layoutGraph;

// debugging options
@property (nonatomic, assign) BOOL showView;
@property (nonatomic, assign) BOOL showViewFrame;
@property (nonatomic, assign) BOOL showDecorationView;
@property (nonatomic, assign) BOOL showDecorationViewFrame;

@end
