//
//  DemoSelectBubbleView.h
//  JFBubbleDemo
//
//  Created by joanfen on 2016/11/17.
//  Copyright © 2016年 joanfen. All rights reserved.
//

#import "JFSelectBubbleView.h"

@interface DemoSelectBubbleView : JFSelectBubbleView

@property (nonatomic, copy) NSArray<NSString *> *tagsArray;

-(void)addTags:(NSArray *)tags;

-(BOOL)highlightItemWithText:(NSString *)text;
-(BOOL)cancelHighlightItemWithText:(NSString *)text;

@end
