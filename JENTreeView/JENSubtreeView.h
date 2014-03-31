//
//  JENSubtreeView.h
//
//  Created by Jennifer Nordwall on 3/8/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JENTreeViewModelNode.h"
#import "JENDecorationView.h"

@interface JENSubtreeView : UIView

-(id)initWithNodeView:(UIView*)nodeView
       decorationView:(UIView<JENDecorationView>*)decorationView;

-(CGSize)layoutGraph;

@property (nonatomic, assign) BOOL invertedLayout;
@property (nonatomic, assign) BOOL alignChildren;
@property (nonatomic, assign) CGFloat parentChildSpacing;
@property (nonatomic, assign) CGFloat siblingSpacing;

// debugging options
@property (nonatomic, assign) BOOL showView;
@property (nonatomic, assign) BOOL showViewFrame;

@end
