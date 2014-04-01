//
//  JENTreeView.m
//
//  Created by Jennifer Nordwall on 3/8/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import "JENTreeView.h"
#import "JENSubtreeView.h"
#import "JENTreeViewModelNode.h"
#import "JENDefaultNodeView.h"

@interface JENTreeView ()

@property (nonatomic, retain) NSMapTable *modelNodeToSubtreeViewMap;

@end

@implementation JENTreeView

-(id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if(self) {
        [self initilize];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        [self initilize];
    }
    return self;
}

-(id)init {
    self = [super init];
    
    if(self) {
        [self initilize];
    }
    return self;
}

-(void)initilize {
    self.modelNodeToSubtreeViewMap  = [NSMapTable weakToStrongObjectsMapTable];
    self.parentChildSpacing         = 40.0;
    self.siblingSpacing             = 10.0;
}

#pragma mark Properties

-(void)setInvertedLayout:(BOOL)invertedLayout {
    if(_invertedLayout != invertedLayout) {
        _invertedLayout = invertedLayout;
        
        [self rootSubtreeView].invertedLayout = invertedLayout;
    }
}

-(void)setAlignChildren:(BOOL)alignChildren {
    if(_alignChildren != alignChildren) {
        _alignChildren = alignChildren;

        [self rootSubtreeView].alignChildren = alignChildren;
    }
}

-(void)setParentChildSpacing:(CGFloat)parentChildSpacing {
    if(_parentChildSpacing != parentChildSpacing) {
        _parentChildSpacing = parentChildSpacing;
        
        [self rootSubtreeView].parentChildSpacing = parentChildSpacing;
    }
}

-(void)setSiblingSpacing:(CGFloat)siblingSpacing {
    if(_siblingSpacing != siblingSpacing) {
        _siblingSpacing = siblingSpacing;
        
        [self rootSubtreeView].siblingSpacing = siblingSpacing;
    }
}

-(void)setShowSubviews:(BOOL)showSubviews {
    if(_showSubviews != showSubviews) {
        _showSubviews = showSubviews;
        
        [self rootSubtreeView].showView = showSubviews;
    }
}

-(void)setShowSubviewFrames:(BOOL)showSubviewFrames {
    if(_showSubviewFrames != showSubviewFrames) {
        _showSubviewFrames = showSubviewFrames;

        [self rootSubtreeView].showViewFrame = showSubviewFrames;
    }
}

-(void)setRootNode:(id<JENTreeViewModelNode>)rootNode {
    if(_rootNode != rootNode) {
        _rootNode = rootNode;
        
        [self reloadData];
    }
}

#pragma mark Build Graph

-(void)reloadData {
    [[self rootSubtreeView] removeFromSuperview];
    [self.modelNodeToSubtreeViewMap removeAllObjects];
	
    [self buildGraph];
    [self layoutGraph];
}

-(void)buildGraph {
    if(self.rootNode) {
        JENSubtreeView *rootSubtreeView = [self buildGraphForModelNode:self.rootNode];
        
        if(rootSubtreeView) {
            [self addSubview:rootSubtreeView];
        }
    }
}

-(JENSubtreeView*)buildGraphForModelNode:(id<JENTreeViewModelNode>)modelNode {
    NSParameterAssert(modelNode);
    
	UIView* nodeView = nil;
	
	if([self.dataSource respondsToSelector:@selector(treeView:nodeViewForModelNode:)]) {
		nodeView = [self.dataSource treeView:self
						nodeViewForModelNode:modelNode];
	}
    
    if(nodeView == nil) {
        nodeView                                = [[JENDefaultNodeView alloc] init];
        ((JENDefaultNodeView*)nodeView).name    = modelNode.name;
    }
	
	UIView<JENDecorationView> *decorationView = nil;
	
	if([self.dataSource respondsToSelector:@selector(treeView:decorationViewForModelNode:)]) {
		decorationView = [self.dataSource treeView:self
						decorationViewForModelNode:modelNode];
	}
    
    JENSubtreeView *subtreeView     = [[JENSubtreeView alloc]
                                       initWithNodeView:nodeView
                                       decorationView:decorationView];
    
    subtreeView.alignChildren       = self.alignChildren;
    subtreeView.invertedLayout      = self.invertedLayout;
    subtreeView.parentChildSpacing  = self.parentChildSpacing;
    subtreeView.siblingSpacing      = self.siblingSpacing;
    subtreeView.showView            = self.showSubviews;
    subtreeView.showViewFrame       = self.showSubviewFrames;
    
    if(subtreeView) {
        [self setSubtreeView:subtreeView forModelNode:modelNode];
        
        NSArray *childModelNodes = [[modelNode children] allObjects];
        
        for(id<JENTreeViewModelNode> childModelNode in childModelNodes) {
            JENSubtreeView *childSubtreeView = [self buildGraphForModelNode:childModelNode];
            
            if(childSubtreeView) {
                [subtreeView addSubview:childSubtreeView];
            }
        }
    }
    return subtreeView;
}

#pragma mark Layout Graph

-(void)layoutGraph {
    CGSize treeViewSize = [[self rootSubtreeView] layoutGraph];
    
    self.contentSize = CGSizeMake(treeViewSize.width + self.parentChildSpacing,
                                  treeViewSize.height);
}

#pragma mark Mapping methods

-(JENSubtreeView*)rootSubtreeView {
    return [self subtreeViewForModelNode:self.rootNode];
}

-(JENSubtreeView*)subtreeViewForModelNode:(id)modelNode {
    return [self.modelNodeToSubtreeViewMap objectForKey:modelNode];
}

-(void)setSubtreeView:(JENSubtreeView*)subtreeView forModelNode:(id)modelNode {
    [self.modelNodeToSubtreeViewMap setObject:subtreeView forKey:modelNode];
}

@end
