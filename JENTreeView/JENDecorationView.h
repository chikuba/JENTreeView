//
//  JENDecorationView.h
//  Example
//
//  Created by Jennifer Nordwall on 3/31/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JENDecorationView

@required

@property (nonatomic, assign) BOOL invertedLayout;
@property (nonatomic, assign) CGFloat parentChildSpacing;

@end
