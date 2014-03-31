//
//  JENCustomDecorationView.h
//  Example
//
//  Created by Jennifer Nordwall on 3/31/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JENDecorationView.h"

@interface JENCustomDecorationView : UIView<JENDecorationView>

@property (nonatomic, assign) BOOL invertedLayout;
@property (nonatomic, assign) BOOL ortogonalConnection;
@property (nonatomic, assign) CGFloat parentChildSpacing;

// debugging purposes
@property (nonatomic, assign) BOOL showView;
@property (nonatomic, assign) BOOL showViewFrame;

@end
