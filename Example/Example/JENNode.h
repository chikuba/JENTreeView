//
//  JENNode.h
//  Example
//
//  Created by Jennifer Nordwall on 3/23/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JENTreeViewModelNode.h"

@interface JENNode : NSObject<JENTreeViewModelNode>

@property (nonatomic, strong) NSSet *children;
@property (nonatomic, strong) NSString *name;

@end
