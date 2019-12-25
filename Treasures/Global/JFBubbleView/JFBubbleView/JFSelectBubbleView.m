//
//  JFSelectBubbleView.m
//  JFBubbleDemo
//
//  Created by joanfen on 2016/11/16.
//  Copyright © 2016年 joanfen. All rights reserved.
//

#import "JFSelectBubbleView.h"
#import "JFBubbleItem.h"

#pragma mark - Class JFSelectBubbleItem
#pragma mark -

@interface JFSelectBubbleItem : JFBubbleItem

@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *hightlightTextColor;
@property (nonatomic, strong) UIColor *normalBgColor;
@property (nonatomic, strong) UIColor *highlightBgColor;

@end

#pragma mark -
@implementation JFSelectBubbleItem

-(instancetype)initWithReuseIdentifier:(NSString *)identifier{
    self = [super initWithReuseIdentifier:identifier];
    if (self) {
        self.normalTextColor = [UIColor whiteColor];
        self.hightlightTextColor = [UIColor whiteColor];
        self.normalBgColor = [UIColor colorWithRed:177.0/255.0 green:184.0/255.0 blue:189.0/255.0 alpha:1];
        self.highlightBgColor = [UIColor colorWithRed:203.0/255.0 green:36.0/255.0 blue:36.0/255.0 alpha:1];
        self.textLabel.textColor = self.normalTextColor;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.backgroundColor = self.normalBgColor;
    }
    return self;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    if (selected) {
        self.textLabel.textColor = self.hightlightTextColor;
        self.layer.borderColor = self.hightlightTextColor.CGColor;
        self.backgroundColor = self.highlightBgColor;
    }
    else{
        self.textLabel.textColor = self.normalTextColor;
        self.layer.borderColor = self.normalTextColor.CGColor;
        self.backgroundColor = self.normalBgColor;
    }
}

@end


#pragma mark - Class JFSelectBubbleView
#pragma mark -

@interface JFSelectBubbleView ()<JFBuddleViewDelegate, JFBuddleViewDataSource>

@end

#pragma mark -

@implementation JFSelectBubbleView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.bubbleDataSource = self;
        self.dataArray = [NSMutableArray new];
        self.allowsMultipleSelection = YES;
    }
    return self;
}

-(void)setDataArray:(NSMutableArray<NSString *> *)dataArray{
    _dataArray = dataArray;
    [self reloadData];
}

#pragma mark - Bubble View Data Source
-(NSInteger)numberOfItemsInBubbleView:(JFBubbleView *)bubbleView{
    return self.dataArray.count;
}

-(JFBubbleItem *)bubbleView:(JFBubbleView *)bubbleView itemForIndex:(NSInteger)index{
    NSString *editReuseIdentifier = @"editBubbleItem";
    JFSelectBubbleItem *item = [bubbleView dequeueReuseItemWithIdentifier:editReuseIdentifier];
    if (item == nil) {
        item = [[JFSelectBubbleItem alloc] initWithReuseIdentifier:editReuseIdentifier];
    }
    item.textLabel.text = [self.dataArray objectAtIndex:index];
    return item;
}


@end
