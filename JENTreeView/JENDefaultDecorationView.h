//
//  JENSubtreeDecorationView.h
//
//  Created by Jennifer Nordwall on 3/8/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JENDecorationView.h"

@class JENTreeView;

@interface JENDefaultDecorationView : UIView<JENDecorationView>

@property (nonatomic, assign) BOOL invertedLayout;
@property (nonatomic, assign) CGFloat parentChildSpacing;

@end
