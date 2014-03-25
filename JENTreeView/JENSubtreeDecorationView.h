//
//  JENSubtreeDecorationView.h
//
//  Created by Jennifer Nordwall on 3/8/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JENTreeView;

@interface JENSubtreeDecorationView : UIView

@property (nonatomic, assign) BOOL invertedLayout;
@property (nonatomic, assign) BOOL ortogonalConnection;
@property (nonatomic, assign) CGFloat parentChildSpacing;

@property (nonatomic, assign) NSInteger lineWidth;
@property (nonatomic, strong) UIColor *lineColor;

// debugging purposes
@property (nonatomic, assign) BOOL showView;
@property (nonatomic, assign) BOOL showViewFrame;

@end
