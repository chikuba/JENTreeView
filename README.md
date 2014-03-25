JENTreeView
===========
This is a simple treeview that creates and layout a treeview recursivly. 

#Usage

Create a Node class that uses the JENTreeViewModelNode protocol: 

  @interface Node : NSObject<JENTreeViewModelNode>

  @property (nonatomic, strong) NSSet *children; // nodes
  @property (nonatomic, strong) Node *parent;
  @property (nonatomic, strong) NSString *name;

@end  

Then build your Node tree of these views. 

Then create a treeView: 

JENTreeView *treeView = [[JENTreeView alloc] init];

Set the rootNode to the root of your Node tree:

treeView.rootNode = root;

Then change the following properites as you like: 

BOOL invertedLayout;
BOOL alignChildren;
BOOL ortogonalConnection;

CGFloat parentChildSpacing;
CGFloat siblingSpacing;

UIColor *nodeBackgroundColor;
UIColor *decorationLineColor;

BOOL showSubviews;
BOOL showSubviewFrames;
BOOL showDecorationViewFrames;
BOOL showDecorationViews;
