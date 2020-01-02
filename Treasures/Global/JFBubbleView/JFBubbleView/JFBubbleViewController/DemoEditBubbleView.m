//
//  DemoEditBubbleView.m
//  JFBubbleDemo
//
//  Created by joanfen on 2016/11/17.
//  Copyright © 2016年 joanfen. All rights reserved.
//

#import "DemoEditBubbleView.h"
#import "JFBubbleHeader.h"

static NSString *kDemoEditBubbleResourceName = @"selectedTags";

@interface DemoEditBubbleView ()

@property (nonatomic, strong) NSString *resourcePath;

@end

@implementation DemoEditBubbleView


-(void)setTags:(NSArray<NSString *> *)tags{
    _tags = tags;
    self.dataArray = tags.mutableCopy;
}

-(void)addBubbleItem:(JFBubbleItem *)item{
    [super addBubbleItem:item];
    [self.dataArray addObject:item.textLabel.text];
    
}

-(void)removeItem:(JFBubbleItem *)item animated:(BOOL)animated{
    [super removeItem:item animated:animated];
    NSString *text = item.textLabel.text;
    if ([self.dataArray containsObject:text]) {
        [self.dataArray removeObject:text];
    }
}

-(void)writeSelectedBubbles{
    [self.dataArray writeToFile:self.resourcePath atomically:YES];
}

-(void)resign {
    [super resignFirstResponder];
}

@end
