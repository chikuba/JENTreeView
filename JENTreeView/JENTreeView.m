//
//  JENTreeView.m
//
//  Created by Jennifer Nordwall on 3/8/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import "JENTreeView.h"

#import "JENSubtreeView.h"
#import "JENTreeViewModelNode.h"

@interface JENTreeView ()

@property (nonatomic, retain) NSMapTable *modelNodeToSubtreeViewMap;

@end

@implementation JENTreeView

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
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

-(void)initilize {
    self.modelNodeToSubtreeViewMap  = [NSMapTable weakToStrongObjectsMapTable];
    self.parentChildSpacing         = 40.0;
    self.siblingSpacing             = 10.0;
    self.nodeBackgroundColor        = [UIColor colorWithRed:0.0f/255.0f
                                                      green:102.0f/255.0f
                                                       blue:142.0f/255.0f
                                                      alpha:1.0f];
}

#pragma mark Properties

-(void)setInvertedLayout:(BOOL)invertedLayout {
    if(_invertedLayout != invertedLayout) {
        _invertedLayout = invertedLayout;
        
        [self rootSubtreeView].invertedLayout = invertedLayout;
        [self layoutGraph];
    }
}

-(void)setAlignChildren:(BOOL)alignChildren {
    if(_alignChildren != alignChildren) {
        _alignChildren = alignChildren;

        [self rootSubtreeView].alignChildren = alignChildren;
        [self layoutGraph];
    }
}

-(void)setOrtogonalConnection:(BOOL)ortogonalConnection {
    if(_ortogonalConnection != ortogonalConnection) {
        _ortogonalConnection = ortogonalConnection;
        
        [self rootSubtreeView].ortogonalConnection = ortogonalConnection;
        [self layoutGraph];
    }
}

-(void)setParentChildSpacing:(CGFloat)parentChildSpacing {
    if(_parentChildSpacing != parentChildSpacing) {
        _parentChildSpacing = parentChildSpacing;
        
        [self rootSubtreeView].parentChildSpacing = parentChildSpacing;
        [self layoutGraph];
    }
}

-(void)setSiblingSpacing:(CGFloat)siblingSpacing {
    if(_siblingSpacing != siblingSpacing) {
        _siblingSpacing = siblingSpacing;
        
        [self rootSubtreeView].siblingSpacing = siblingSpacing;
        [self layoutGraph];
    }
}

-(void)setNodeBackgroundColor:(UIColor*)nodeBackgroundColor {
    if(_nodeBackgroundColor != nodeBackgroundColor) {
        _nodeBackgroundColor = nodeBackgroundColor;
        
        [self rootSubtreeView].nodeBackgroundColor = nodeBackgroundColor;
    }
}

-(void)setDecorationLineColor:(UIColor *)decorationLineColor {
    if(_decorationLineColor != decorationLineColor) {
        _decorationLineColor = decorationLineColor;
        
        [self rootSubtreeView].decorationLineColor = decorationLineColor;
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

-(void)setShowDecorationViewFrames:(BOOL)showDecorationViewFrames {
    if(_showDecorationViewFrames != showDecorationViewFrames) {
        _showDecorationViewFrames = showDecorationViewFrames;
        
        [self rootSubtreeView].showDecorationViewFrame = showDecorationViewFrames;
    }
}

-(void)setShowDecorationViews:(BOOL)showDecorationViews {
    if(_showDecorationViews != showDecorationViews) {
        _showDecorationViews = showDecorationViews;
        
        [self rootSubtreeView].showDecorationView = showDecorationViews;
    }
}

-(void)setRootNode:(id<JENTreeViewModelNode>)rootNode {
    NSParameterAssert(rootNode == nil ||
                      [rootNode conformsToProtocol:@protocol(JENTreeViewModelNode)]);
    
    if(_rootNode != rootNode) {
        [[self rootSubtreeView] removeFromSuperview];
        [self.modelNodeToSubtreeViewMap removeAllObjects];
        
        _rootNode = rootNode;
        
        [self buildGraph];
        [self layoutGraph];
    }
}

#pragma mark Build Graph

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
    
    JENSubtreeView *subtreeView     = [[JENSubtreeView alloc] initWithModelNode:modelNode];
    subtreeView.alignChildren       = self.alignChildren;
    subtreeView.invertedLayout      = self.invertedLayout;
    subtreeView.parentChildSpacing  = self.parentChildSpacing;
    subtreeView.siblingSpacing      = self.siblingSpacing;
    subtreeView.ortogonalConnection = self.ortogonalConnection;
    subtreeView.nodeBackgroundColor = self.nodeBackgroundColor;
    subtreeView.decorationLineColor = self.decorationLineColor;
    
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
