//
//  JENNodeView.m
//
//  Created by Jennifer Nordwall on 3/14/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import "JENDefaultNodeView.h"

@interface JENDefaultNodeView ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation JENDefaultNodeView

-(id)init {
    self = [super init];
    
    if(self) {
        self.nameLabel = [[UILabel alloc] init];
        
        self.nameLabel.text = self.name;
        
        [self addSubview:self.nameLabel];
    }
    return self;
}

-(void)setName:(NSString *)name {
    if(name != _name) {
        _name = name;
        
        self.nameLabel.text = name;
        
        NSDictionary *attributes = @{NSFontAttributeName: self.nameLabel.font};
        
        self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                [self.name sizeWithAttributes:attributes].width + 10,
                                [self.name sizeWithAttributes:attributes].height + 10);
        
        self.nameLabel.frame = CGRectMake(self.bounds.origin.x + 5,
                                          self.bounds.origin.y + 5,
                                          self.bounds.size.width - 10,
                                          self.bounds.size.height - 10);
    }
}

@end
