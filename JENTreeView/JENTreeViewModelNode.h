//
//  JENTreeViewModelNode.h
//
//  Created by Jennifer Nordwall on 3/8/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JENTreeViewModelNode <NSObject>

@required

@property (nonatomic, strong) NSSet *children;
@property (nonatomic, strong) NSString *name;

@end
