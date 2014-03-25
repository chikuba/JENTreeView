//
//  JENNodeView.m
//
//  Created by Jennifer Nordwall on 3/14/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import "JENNodeView.h"

@interface JENNodeView ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation JENNodeView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.nameLabel = [[UILabel alloc]
                           initWithFrame:CGRectMake(self.bounds.origin.x + 5,
                                                    self.bounds.origin.y + 5,
                                                    self.bounds.size.width - 10,
                                                    self.bounds.size.height - 10)];        
        self.nameLabel.text = self.name;
        
        [self addSubview:self.nameLabel];
    }
    return self;
}

-(void)setName:(NSString *)name {
    if(name != _name) {
        self.nameLabel.text = name;
        _name = name;
    }
}

@end
