//
//  JENViewController.h
//  Example
//
//  Created by Jennifer Nordwall on 3/23/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JENTreeView.h"

@interface JENViewController : UIViewController<JENTreeViewDataSource>

@property (nonatomic, retain) IBOutlet JENTreeView *treeView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *invertedLayout;
@property (nonatomic, retain) IBOutlet UISegmentedControl *alignChildren;
@property (nonatomic, retain) IBOutlet UISegmentedControl *decorationViewType;
@property (nonatomic, retain) IBOutlet UISwitch *showViewFrames;
@property (nonatomic, retain) IBOutlet UISwitch *showViews;


@end
