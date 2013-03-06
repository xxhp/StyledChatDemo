//
//  CustomTextFiled.m
//  StyledChatDemo
//
//  Created by xiaohaibo on 13-3-1.
//  Copyright (c) 2013年 xiaohaibo. All rights reserved.
//

#import "CustomTextFiled.h"

@implementation CustomTextFiled
@synthesize storedString;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//    Code:
        // Add a "textFieldDidChange" notification method to the text field control.
        storedString = [[NSMutableString alloc] init];
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)textFieldDidChange:(id)sender{
    storedString =  [storedString appenString:text];
}
@end
