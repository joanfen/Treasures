//
//  DemoSelectBubbleView.m
//  JFBubbleDemo
//
//  Created by joanfen on 2016/11/17.
//  Copyright © 2016年 joanfen. All rights reserved.
//

#import "DemoSelectBubbleView.h"

static NSString *const kDemoSelectBubbleResourceName = @"tags";

@interface DemoSelectBubbleView ()

@property (nonatomic, strong) NSString *resourcePath;

@end

@implementation DemoSelectBubbleView


-(void)setTagsArray:(NSArray<NSString *> *)tagsArray {
    _tagsArray = tagsArray;
    self.dataArray = tagsArray.mutableCopy;
}

-(void)addTags:(NSArray *)tags{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.dataArray];
    [array addObjectsFromArray:tags];
    [array writeToFile:self.resourcePath atomically:YES];
}

-(BOOL)highlightItemWithText:(NSString *)text{
    if ([self.dataArray containsObject:text]) {
        [self selectBubbleAtIndex:[self.dataArray indexOfObject:text]];
    }
    return NO;
}

-(BOOL)cancelHighlightItemWithText:(NSString *)text{
    if ([self.dataArray containsObject:text]) {
        [self deselectBubbleAtIndex:[self.dataArray indexOfObject:text]];
    }
    return NO;
}
@end
