//
//  JENTreeView.h
//
//  Created by Jennifer Nordwall on 3/8/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JENTreeViewModelNode.h"
#import "JENDecorationView.h"

@class JENTreeView;

@protocol JENTreeViewDataSource <NSObject>

@optional
-(UIView*)treeView:(JENTreeView*)treeView
    nodeViewForModelNode:(id<JENTreeViewModelNode>)modelNode;

-(UIView<JENDecorationView>*)treeView:(JENTreeView*)treeView
    decorationViewForModelNode:(id<JENTreeViewModelNode>)modelNode;

@end

@interface JENTreeView : UIScrollView

@property (nonatomic, retain) id<JENTreeViewModelNode> rootNode;
@property (nonatomic, assign) id<JENTreeViewDataSource> dataSource;

-(void)layoutGraph;
-(void)reloadData;

// subview properties 
@property (nonatomic, assign) BOOL invertedLayout;
@property (nonatomic, assign) BOOL alignChildren;
@property (nonatomic, assign) CGFloat parentChildSpacing;
@property (nonatomic, assign) CGFloat siblingSpacing;

// debugging options
@property (nonatomic, assign) BOOL showSubviews;
@property (nonatomic, assign) BOOL showSubviewFrames;

@end
